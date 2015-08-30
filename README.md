# Leftist trees: immutable priority queues for Racket

Jon Zeppieri <[zeppieri@gmail.com](mailto:zeppieri@gmail.com)>

To install:
```sh
raco pkg install leftist-tree
```

To use:
```racket
(require leftist-tree)
```

[Leftist trees](https://en.wikipedia.org/wiki/Leftist_tree) provide a
simple representation for immutable priority queues.

| Operation  | Time complexity |
| --------   | --------------- |
| get-min    | O(1)            |
| remove-min | O(log n)        |
| insert     | O(log n)        |

[Read the documentation](http://pkg-build.racket-lang.org/doc/leftist-tree/index.html)
