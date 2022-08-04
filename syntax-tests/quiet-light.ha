// License: MPL-2.0
// (c) 2021 Alexey Yerin <yyp@disroot.org>
// (c) 2021 Drew DeVault <sir@cmpwn.com>
// (c) 2021 Eyal Sawady <ecs@d2evs.net>

fn prototype(lexer: *lex::lexer) (ast::func_type | error) = {
	let variadism = ast::variadism::NONE;
	let params: []ast::func_param = [];
	want(lexer, ltok::LPAREN)?;
	for (try(lexer, ltok::RPAREN)? is void) {
		let loc = lex::mkloc(lexer);
		match (try(lexer, ltok::ELLIPSIS)?) {
		case void =>
			yield void;
		case lex::token =>
			synassert(loc, len(params) > 0,
				"Expected at least one non-variadic parameter for C-style variadism")?;
			variadism = ast::variadism::C;
			try(lexer, ltok::COMMA)?;
			want(lexer, ltok::RPAREN)?;
			break;
		};

		let name = match (try(lexer, ltok::UNDERSCORE)?) {
		case void =>
			yield want(lexer, ltok::NAME)?.1 as str;
		case lex::token =>
			yield "";
		};

		want(lexer, ltok::COLON)?;
		append(params, ast::func_param {
			loc = loc,
			name = name,
			_type = alloc(_type(lexer)?),
		});
		match (try(lexer, ltok::ELLIPSIS)?) {
		case void =>
			yield void;
		case lex::token =>
			variadism = ast::variadism::HARE;
			try(lexer, ltok::COMMA)?;
			want(lexer, ltok::RPAREN)?;
			break;
		};
		match (try(lexer, ltok::COMMA)?) {
		case void =>
			want(lexer, ltok::RPAREN)?;
			break;
		case lex::token => void;
		};
	};
	let t = _type(lexer)?;
	return ast::func_type {
		result = alloc(t),
		attrs = ast::func_attrs::NONE,
		variadism = variadism,
		params = params,
	};
};