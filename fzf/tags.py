#!/usr/bin/env python

from collections import defaultdict
import argparse, sys

global_kinds = [ 'i', 'n', 'c', 't', 'f', 'F' ]
member_kinds = [ 'r', 'e', 'm', 'w' ]
variable_kinds = [ 'v', 'c', 's', 'u', 'd', 'g' ]
ignore_kinds = [ 'p', 'l', 'a' ]

def tabrize( s, width ):
    if len( s ) < width:
        n = ( width - len( s ) )
        s += '\t' * ( n / 8 + ( 1 if n % 8 else 0 ) )
    return s

def get_name( kind, fields ):
    name = fields[ 0 ]
    if kind in member_kinds:
        try:
            name = fields[ 5 ].split( ':' )[ 1 ] + ':' + name
        except IndexError:
            try:
                name = fields[ -1 ].split( ':' )[ 1 ] + ':' + name
            except IndexError:
                pass
    return name

def get_kind( fields ):
    path, kind = fields[ 1 ], fields[ 3 ]
    if path.endswith( '.go' ):
        if kind == 'c':
            kind = 'v'
        elif kind == 'n':
            kind = 'i'
        elif kind == 'i':
            kind = 'a'
    elif path.endswith( '.py' ):
        if kind == 'i':
            kind = 'a'
    return kind

def handle_tags( lines ):
    results = defaultdict( list )

    for line in lines:
        fields = line.rstrip().split( '\t' )
        if line.startswith( '!' ) or line.startswith( '__' ) or \
                len( fields[ 0 ] ) < 3 or len( line ) > 512:
            continue

        kind = get_kind( fields )
        name = get_name( kind, fields )
        sign = fields[ -1 ].split( ':' )[ -1 ] if len( fields[ -1 ] ) > 1 else ''
        sign = tabrize( sign, 16 )
        path, loc = tabrize( fields[ 1 ], 24 ), fields[ 2 ]
        if loc.startswith( '/^' ):
            loc = tabrize( loc, 40 )

	if not args.G or (kind in global_kinds + variable_kinds):
	    results[ kind ].append( '\t'.join(
		[ name.ljust( 32 ), path, loc, kind, sign, tags ]
            ) )

        if kind not in global_kinds + member_kinds + variable_kinds + ignore_kinds:
            print 'Unknown type:', kind, line

    for kind in global_kinds + member_kinds + variable_kinds:
        for line in results[ kind ]:
            print line

parser = argparse.ArgumentParser()
parser.add_argument( 'tags_list', metavar='tags_list', type=str, nargs='+' )
parser.add_argument('-G', dest='G', action='store_const', const=True, default=False )
args = parser.parse_args()

for tags in args.tags_list:
    with open( tags, 'r' ) as f:
        lines = f.readlines()
        for i, line in enumerate( lines ):
            if not line.startswith( '!' ):
                handle_tags( lines[ i: ] )
                break
