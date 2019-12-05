#[derive(Debug, Clone, PartialEq)]
pub struct Machine {
    pub r0: i32,
    pub r1: i32,
    pub r2: i32,
}

impl Machine {
    pub fn new() -> Machine {
        Machine {
            r0: 0,
            r1: 0,
            r2: 0,
        }
    }

    pub fn do_move(&self, r: u8, v: i32) -> Machine {
        match r {
            0 => Machine {
                r0: v,
                r1: self.r1,
                r2: self.r2,
            },
            1 => Machine {
                r0: self.r0,
                r1: v,
                r2: self.r2,
            },
            2 => Machine {
                r0: self.r0,
                r1: self.r1,
                r2: v,
            },
            _ => self.clone(),
        }
    }

    pub fn do_add(&self) -> Machine {
        let Machine { r0, r1, r2: _ } = self;
        self.do_move(2, r0 + r1).do_move(0, 0).do_move(1, 0).clone()
    }

    pub fn read(&self, r: u8) -> i32 {
        match r {
            0 => self.r0,
            1 => self.r1,
            2 => self.r2,
            _ => 0,
        }
    }
}
