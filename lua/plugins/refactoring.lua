-- This is temproarily required because of some undeclared dependency
-- in future versions of lazyvim it won't be necessary
return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "lewis6991/async.nvim",
  },
}
