(** Mutable sequence of elements. *)

type 'a t
(** Type of a sequence holding values of type ['a]. *)

type 'a node = private {
    mutable prev: 'a t
  ; mutable next: 'a t
  ; mutable data: 'a
  ; mutable active: bool
}
(** Type of a node holding one value of type ['a] in a sequence.

    {b NOTE}: The user can deconstruct a node to avoid indirect access to
    values, but it is not advisable to modify the fields. *)

type direction =
  | Right
  | Left  (** Type of directions used by {!val:add} and {!val:take}. *)

exception Empty
(** Exception raised by {!val:take} when the sequence is empty. *)

val create : unit -> 'a t
(** [create ()] creates a new empty sequence. *)

val take : direction -> 'a t -> 'a
(** [take direction t] takes an element of [t] from the specified [direction].
*)

val peek_node : direction -> 'a t -> 'a node

val add : direction -> 'a t -> 'a -> unit
(** [add direction t] adds a new element into [t] to the specified [direction].
*)

val drop : 'a t -> unit
(** Removes all nodes from the given sequence. The nodes are not actually
    mutated to not their removal. Only the sequence's pointers are update. *)

val length : 'a t -> int
(** Returns the number of elements in the given sequence. This is a [O(n)]
    operation where [n] is the number of elements in the sequence. *)

val exists : ('a -> bool) -> 'a t -> bool

val iter : f:('a -> unit) -> 'a t -> unit
(** [iter ~f s] applies [f] on all elements of [s] starting from left. *)

val iter_node : f:('a node -> unit) -> 'a t -> unit
(** [iter_node ~f s] applies [f] on all nodes of [s] starting from left. *)

val is_empty : 'a t -> bool
(** Returns [true] iff the given sequence is empty. *)

val remove : 'a node -> unit
(** Removes a node from the sequence it is part of. It does nothing if the node
    has already been removed. *)

val data : 'a node -> 'a
(** Returns the contents of a node. *)

val to_list : 'a t -> 'a list
(** Returns the given sequence as a list. *)
