#[no_std]
#[macro_use]
extern crate lazy_static;
extern crate mut_static;

mod am;

use mut_static::MutStatic;

use am::Machine;

lazy_static! {
    pub static ref MACHINE: MutStatic<Machine> = { MutStatic::from(Machine::new()) };
}

#[no_mangle]
pub extern "C" fn add() -> i32 {
    let am = MACHINE.read().unwrap().do_add();
    let res = am.read(2);
    res
}

#[no_mangle]
pub extern "C" fn mv(r: u8, v: i32) -> i32 {
    let am = MACHINE.read().unwrap().do_move(r, v.into());
    MACHINE.set(am);
    0
}
