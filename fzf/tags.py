#!/usr/bin/env python

from collections import defaultdict
import argparse, sys

def tabrize( s, width ):
    if len( s ) < width:
        n = ( width - len( s ) )
        s += '\t' * ( n / 8 + ( 1 if n % 8 else 0 ) )
    return s

def tags_handler( lines ):
    global_types = [ 'n', 't', 'f' ]
    member_types = [ 'r', 'e', 'm', 'w' ]
    variable_types = [ 'v', 'c' ]
    ignore_types = [ 'p', 'i' ]

    results = defaultdict( list )

    for line in lines:
        fields = line.rstrip().split( '\t' )
        if line.startswith( '!' ) or line.startswith( '__' ) or \
                len( fields[ 0 ] ) < 3 or len( line ) > 512:
            continue

        name, kind = fields[ 0 ], fields[ 3 ]
        sign = fields[ -1 ].split( ':' )[ -1 ] if len( fields[ -1 ] ) > 1 else ''
        sign = tabrize( sign, 16 )
        if kind in member_types:
            try:
                name = fields[ 5 ].split( ':' )[ 1 ] + ':' + name
            except IndexError:
                try:
                    name = fields[ -1 ].split( ':' )[ 1 ] + ':' + name
                except IndexError:
                    pass
        path, loc = tabrize( fields[ 1 ], 24 ), fields[ 2 ]
        if loc.startswith( '/^' ):
            loc = tabrize( loc, 40 )

	if not args.G or (kind in global_types + variable_types):
	    results[ kind ].append( '\t'.join(
		[ name.ljust( 32 ), path, loc, kind, sign, tags ]
            ) )

        if kind not in global_types + member_types + variable_types + ignore_types:
            print kind

    for kind in global_types + member_types + variable_types:
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
                tags_handler( lines[ i: ] )
                break
