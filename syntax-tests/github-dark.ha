// License: MPL-2.0
// (c) 2021 Alexey Yerin <yyp@disroot.org>
// (c) 2021 Bor Grošelj Simić <bor.groseljsimic@telemach.net>
// (c) 2021 Drew DeVault <sir@cmpwn.com>
// (c) 2021 Eyal Sawady <ecs@d2evs.net>
// (c) 2022 Sebastian <sebastian@sebsite.pw>

@test fn binarithm() void = {
	roundtrip("export fn main() void = *void + void * void / void;\n");
};

@test fn binding() void = {
	roundtrip("export fn main() void = {
	let x: int = 1337, y = 7331;
	const z: int = 42, q: int = 24;
	const (foo, bar): (int, bool) = (42, true);
	const (foo, _, bar): (int, uint, bool) = (42, 12u, true);
	static let p: int = 62893, o = 39826;
	static const w: int = 62893, t = 39826;
};
");
};

@test fn builtin() void = {
	roundtrip(`export fn main() void = {
	alloc(1234);
	alloc(1234...);
	alloc(4321, 1234);
	append(x, 10);
	append(x, 10...);
	append(x, 10, 20, 30);
	append(x, y, z, q...);
	static append(x, 10);
	abort();
	abort("surprize");
	static abort();
	static abort("surprize");
	assert(x == 12);
	assert(x == 12, "number mismatch");
	static assert(x == 12);
	static assert(x == 12, "number mismatch");
	delete(x[10]);
	delete(x[10..20]);
	delete(x[..]);
	delete(x.y.z[..]);
	static delete(x[10]);
	free(x);
	insert(x[0], foo);
	insert(x[0], foo...);
	insert(x[0], foo, bar...);
	static insert(x[0], foo);
	len([1, 2, 3, 4]);
	offset(foo.bar);
	size(u32);
	vastart();
	vaarg(va);
	vaend(va);
};
`);
};