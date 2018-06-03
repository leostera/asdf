module Debug = {
  let print_list = a =>
    switch (a) {
    | [] =>
      print_string("Nil");
      ();
    | _ =>
      a
      |> String.concat(", ")
      |> (s => String.concat("", ["[", s, "]"]))
      |> print_string
    };
};

let intersperse = (~elem, l) => {
  let rec inter = (elem, l, acc) =>
    switch (l) {
    | [] => acc
    | [x, ...xs] => inter(elem, xs, [x, elem, ...acc])
    };
  inter(elem, l, []) |> List.rev |> List.tl;
};

module MaxSubarray = {
  let stock = [|
    13.0,
    (-3.0),
    (-25.0),
    20.0,
    (-3.0),
    (-16.0),
    (-23.0),
    18.0,
    20.0,
    (-7.0),
    12.0,
    (-5.0),
    (-22.0),
    15.0,
    (-4.0),
    7.0,
  |];
  let find_max_crossing = (~a, ~low, ~mid, ~high) => {
    let max_left = ref(-1);
    let left_sum = ref(neg_infinity);
    let tmp_left_sum = ref(0.000);
    for (i in mid downto low) {
      tmp_left_sum := tmp_left_sum.contents +. a[i];
      let new_sum_bigger = tmp_left_sum.contents > left_sum.contents;
      if (new_sum_bigger) {
        left_sum := tmp_left_sum.contents;
        max_left := i;
      };
    };
    let max_right = ref(-1);
    let right_sum = ref(neg_infinity);
    let tmp_right_sum = ref(0.0);
    for (j in mid + 1 to high) {
      tmp_right_sum := tmp_right_sum.contents +. a[j];
      if (tmp_right_sum.contents > right_sum.contents) {
        right_sum := tmp_right_sum.contents;
        max_right := j;
      };
    };
    (
      max_left.contents,
      max_right.contents,
      left_sum.contents +. right_sum.contents,
    );
  };
  let find_max_subarray = arr => {
    let rec find_max = (~a, ~low, ~high) =>
      if (low == high) {
        (low, high, a[low]);
      } else {
        let mid = (low + high) / 2;
        let (left_low, left_high, left_sum) = find_max(~a, ~low, ~high=mid);
        let (right_low, right_high, right_sum) =
          find_max(~a, ~low=mid + 1, ~high);
        let (cross_low, cross_high, cross_sum) =
          find_max_crossing(~a, ~low, ~mid, ~high);
        if (left_sum >= right_sum && left_sum >= cross_sum) {
          (left_low, left_high, left_sum);
        } else if (right_sum >= left_sum && right_sum >= cross_sum) {
          (right_low, right_high, right_sum);
        } else {
          (cross_low, cross_high, cross_sum);
        };
      };
    find_max(~a=arr, ~low=1, ~high=Array.length(arr) - 1);
  };
};

module AllOpsForCombinations = {
  let input = "123";
  let join = String.concat("");
  let char_to_str = String.make(1);
  let tokenize = s => {
    let rec tokenize' = (i, acc) =>
      i < 0 ? acc : tokenize'(i - 1, [char_to_str(s.[i]), ...acc]);
    tokenize'(String.length(s) - 1, []);
  };
  let (>+<) = (a, b) => int_of_string(a) + int_of_string(b);
  let (>-<) = (a, b) => int_of_string(a) - int_of_string(b);
  let rec combine = parts =>
    switch (parts) {
    | [] => []
    | [head, ...tail] when List.length(tail) == 0 => [[head]]
    | [head, ...tail] =>
      let f = x => [
        [head, "+", ...x],
        [head, "-", ...x],
        [join([head, List.hd(x)]), ...List.tl(x)],
      ];
      combine(tail) |> List.map(f) |> List.concat;
    };
  let evaluate = expr => {
    let rec eval = l =>
      switch (l) {
      | [a, ...xs] when List.length(xs) == 0 => int_of_string(a)
      | [a, "+", b, ...xs] => eval([string_of_int(a >+< b), ...xs])
      | [a, "-", b, ...xs] => eval([string_of_int(a >-< b), ...xs])
      | _ => 0
      };
    eval(expr);
  };
  let run = () => input |> tokenize |> combine |> List.map(evaluate);
};
