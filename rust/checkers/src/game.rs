use super::board::{Color, Coordinate, Move, Piece};

pub struct Engine {
    board: [[Option<Piece>; 8]; 8],
    current_turn: Color,
    move_count: u32,
}

pub struct MoveResult {
    pub mv: Move,
    pub crowned: bool,
}

impl Engine {
    pub fn new() -> Engine {
        let mut engine = Engine {
            board: [[None; 8]; 8],
            current_turn: Color::Black,
            move_count: 0,
        };
        engine.initialize_pieces();
        engine
    }

    pub fn initialize_pieces(&mut self) {
        [1, 3, 5, 7, 0, 2, 4, 6, 1, 3, 5, 7]
            .iter()
            .zip([0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2].iter())
            .map(|(a, b)| (*a as usize, (*b as usize)))
            .for_each(|(x, y)| self.board[x][y] = Some(Piece::new(Color::White)));

        [0, 2, 4, 6, 1, 3, 5, 7, 0, 2, 4, 6]
            .iter()
            .zip([5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7].iter())
            .map(|(a, b)| (*a as usize, (*b as usize)))
            .for_each(|(x, y)| self.board[x][y] = Some(Piece::new(Color::Black)));
    }

    pub fn move_piece(&mut self, mv: &Move) -> Result<MoveResult, ()> {
        let legal_moves = self.legal_moves();

        if !legal_moves.contains(mv) {
            return Err(());
        }

        let Coordinate(x0, y0) = mv.from;
        let Coordinate(x1, y1) = mv.to;

        let piece = self.board[x0][y0].unwrap();
        let midpiece_coordinate = self.midpiece_coordinate(x0, y0, x1, y1);

        if let Some(Coordinate(x, y)) = midpiece_coordinate {
            self.board[x][y] = None;
        }

        self.board[x1][y1] = Some(piece);
        self.board[x0][y0] = None;

        // let crowned = if self.should_crown(piece, mv.to) {
        //     self.crown_piece(mv.to);
        //     true
        // } else {
        //     false
        // };

        //self.advance_turn();

        Ok(MoveResult {
            mv: mv.clone(),
            crowned: false,
        })
    }

    fn legal_moves(&self) -> Vec<Move> {
        let mut moves: Vec<Move> = Vec::new();
        for col in 0..8 {
            for row in 0..8 {
                if let Some(piece) = self.board[col][row] {
                    if piece.color == self.current_turn {
                        let loc = Coordinate(col, row);
                        let mut vmoves = self.valid_moves_from(loc);
                        moves.append(&mut vmoves);
                    }
                }
            }
        }
        moves
    }

    fn valid_moves_from(&self, loc: Coordinate) -> Vec<Move> {
        let Coordinate(x, y) = loc;
        if let Some(p) = self.board[x][y] {
            let mut jumps = loc
                .jump_targets_from()
                //.filter(|t| self.valid_jump(&p, &loc, &t))
                .map(|ref t| Move {
                    from: loc.clone(),
                    to: t.clone(),
                })
                .collect::<Vec<Move>>();
            let mut moves = loc
                .move_targets_from()
                //.filter(|t| self.valid_move(&p, &loc, &t))
                .map(|ref t| Move {
                    from: loc.clone(),
                    to: t.clone(),
                })
                .collect::<Vec<Move>>();
            jumps.append(&mut moves);
            jumps
        } else {
            Vec::new()
        }
    }
}
