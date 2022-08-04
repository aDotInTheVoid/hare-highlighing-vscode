// License: MPL-2.0
// (c) 2022 Alexey Yerin <yyp@disroot.org>
// (c) 2021 Byron Torres <b@torresjrjr.com>
// (c) 2021 Drew DeVault <sir@cmpwn.com>
// (c) 2021 Eyal Sawady <ecs@d2evs.net>

use strio;

// All possible error types.
export type error = !lex::error;

// Convert an error into a human-friendly string.
export fn strerror(err: error) const str = lex::strerror(err: lex::error);

fn syntaxerr(
	loc: lex::location,
	fmt: str,
	args: fmt::field...
) lex::error = {
	let why = fmt::asprintf(fmt, args...);
	return (loc, why): lex::syntax: lex::error;
};