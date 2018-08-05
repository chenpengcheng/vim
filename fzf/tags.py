#!/usr/bin/env python

from collections import defaultdict
import argparse
import os

TYPES = ['i', 'n', 'c', 't', 'f', 'F']
VARS = ['v', 'c', 's', 'u', 'd', 'g']
MEMBER = ['r', 'e', 'm', 'w']
IGNORE = ['p', 'l', 'a']


def indent(s, width):
    tab_size = 8

    if len(s) < width:
        n = (width - len(s))
        s += '\t' * (n / tab_size + (1 if n % tab_size else 0))

    return s


def get_tag_name(fields):
    name, path, kind = fields[0], fields[1], get_tag_type(fields)

    if path.endswith('.go') and kind == 'm' and fields[6].startswith('ntype'):
        fields[5], fields[6] = fields[6], fields[5]

    if kind in MEMBER:
        try:
            name = fields[5].split(':')[1] + ':' + name
        except IndexError:
            try:
                name = fields[-1].split(':')[1] + ':' + name
            except IndexError:
                pass

    return name


def get_tag_type(fields):
    path, kind = fields[1], fields[3]

    if path.endswith('.go'):
        kindMap = {
            'c': 'v',
            'n': 'i',
            'i': 'a',
        }
        return kindMap.get(kind, kind)

    elif path.endswith('.py'):
        kindMap = {
            'i': 'a',
        }
        return kindMap.get(kind, kind)

    return kind


def get_tag_signature(fields):
    if len(fields[-1]) > 1:
        return fields[-1].split(':')[-1]
    else:
        return ''


def fix_tags(dirname, lines):
    results = defaultdict(list)

    for line in lines:
        if len(line) > 512 or line.startswith('!') or line.startswith('__'):
            continue

        fields = line.rstrip().split('\t')
        if len(fields[0]) < 3:
            continue

        kind = get_tag_type(fields)
        name = get_tag_name(fields)

        signature = get_tag_signature(fields)
        signature = indent(signature, 24)

        path = fields[1]
        if path.startswith(dirname):
            path = path[len(dirname) + 1:]
        path = indent(path, 56)

        loc = fields[2]
        if loc.startswith('/'):
            loc = indent(loc, 40)

        if (kind in TYPES + VARS) or args.include_local:
            results[kind].append(
                '\t'.join([name.ljust(32), path, loc, kind, signature])
            )

        if kind not in TYPES + MEMBER + VARS + IGNORE:
            print 'Unknown type:', kind, line

    for kind in TYPES + MEMBER + VARS:
        for line in results[kind]:
            print line


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('tags_list', metavar='tags_list', type=str, nargs='+')
    parser.add_argument(
        '-include-local',
        dest='include_local',
        action='store_const',
        const=True,
        default=True,
    )
    args = parser.parse_args()

    for tags in args.tags_list:
        with open(tags, 'r') as f:
            fix_tags(os.getcwd(), f.readlines())
