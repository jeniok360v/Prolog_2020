p1 --> [].
p1 --> `a`, p1, `b`.

p2 --> p2(_).
p2(X) --> p2a(X), p2bc(X).

p2a(z) --> ``.
p2a(t(N)) --> `a`, p2a(N).

p2bc(z) --> ``.
p2bc(t(N)) --> `b`, p2bc(N), `c`.

p3 --> p3(_).
p3(X) --> p3a(X), p3fib(X).

p3a(z) --> ``.
p3a(t(X)) --> `a`, p3a(X).

p3fib(z) --> ``.
p3fib(t(z)) --> `b`.
p3fib(t(t(X))) --> p3fib(X), p3fib(t(X)).