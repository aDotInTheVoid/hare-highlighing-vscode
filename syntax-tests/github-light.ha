// License: MPL-2.0
// (c) 2021 Drew DeVault <sir@cmpwn.com>
// (c) 2021 Eyal Sawady <ecs@d2evs.net>
use hare::ast;
use hare::lex;
use hare::lex::{ltok};

use fmt;

fn name_list(lexer: *lex::lexer) ([]((str | void), str) | error) = {
	let names: []((str | void), str) = [];
	for (true) {
		append(names, (void, want(lexer, ltok::NAME)?.1 as str));
		match (try(lexer, ltok::EQUAL)?) {
		case void => void;
		case =>
			let name = &names[len(names) - 1];
			name.0 = name.1;
			name.1 = want(lexer, ltok::NAME)?.1 as str;
		};

		switch (want(lexer, ltok::EQUAL, ltok::COMMA, ltok::RBRACE)?.0) {
		case ltok::COMMA =>
			match (try(lexer, ltok::RBRACE)?) {
			case void => void;
			case =>
				return names;
			};
		case ltok::RBRACE =>
			return names;
		case => abort(); // Unreachable
		};
	};
	abort();
};