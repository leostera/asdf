/*
 *   string balance(string expr)
 *     "a)()" -> "a()"
 *       ")(a))(c(b)(" -> "(a)c(b)"
 *       */
// ")(" -> open = 1, closed = 1
// "(((b(a)" -> "(ba)"
// "(" -> rec "((()"
// "(" -> rec "(()"
// "(" -> rec "()" // 
// "(" -> rec ")" // closed parenthesis
// 
// "(((b(a)" -> "(ba)"
// open 1
// open 2
// open 3
// b --
// open 4
// a --
// closed 1
// open 4 closed 1
// 
// ")(a()("
// balance_count = 0
// acc = "
// 
// ")" -- balance_count = -1, acc = "
// "(" -- balance_count =  1, acc = "("
// "(" -- balance_count =  2, acc = "(("
// ")" -- balance_count =  1, acc = "(()"
// "(" -- balance_count =  2, acc = "(()("
// "  -- balance_count =  2, acc = "(()("

const balance_iter = s => balance_count => acc => {
  if (s === ")") return acc

  const [fst, ...rest] = s
  const is_open_parens = fst === "("
  const is_closed_parens = fst === ")"
  const is_parens = is_closed_parens || is_open_parens

  const last_balance = balance_count < 0 ? 0 : balance_count
  const next_balance = last_balance + ( is_parens ? ( is_open_parens ? 1 : -1 ) : 0 )

  const should_add_to_acc = next_balance >= 0
  const next_acc = should_add_to_acc ? acc.push(fst) : acc

  return balance_iter(rest)(next_balance)(next_acc)
}

const balance = s => balance_iter(s)(0)([])
