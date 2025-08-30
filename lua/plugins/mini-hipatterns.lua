return {
  "echasnovski/mini.hipatterns",
  optional = true,
  opts = {
    highlighters = {
      fixme = { pattern = '%f[%w]()FIXME()%f[%W]' , group = 'MiniHipatternsFixme' },
      hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
      todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
      xxx  = { pattern = '%f[%w]()XXX()%f[%W]',  group = 'MiniHipatternsTodo'  },
      note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
      jpc  = { pattern = '%f[%w]()JPC()%f[%W]',  group = 'MiniHipatternsNote'  },
    }

  }
}
