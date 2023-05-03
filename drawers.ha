fn draw_background =>
    Ncurses::col(4)
    for i until LINES
        for j until COLS
            Ncurses::add(i, j, " ")
        ;
    ;
    Ncurses::col(4, false)
;

fn draw_ground =>
    for i until COLS
        Ncurses::col(10)
        Ncurses::add(LINES - 3, i, "🭶")
        Ncurses::col(9)
        Ncurses::add(LINES - 2, i, "🮀")
        Ncurses::col(8)
        Ncurses::add(LINES - 1, i, "🮁")
    ;
    Ncurses::col(5, false)
;

fn draw_moon =>
    Ncurses::col(4)
    Ncurses::add_until(2, COLS - 10, "███████████████", COLS, true)
    Ncurses::add_until(3, COLS - 13, "██████████████", COLS, true)
    Ncurses::add_until(4, COLS - 16, "██████████████", COLS, true)
    Ncurses::add_until(5, COLS - 18, "██████████████", COLS, true)
    Ncurses::add_until(6, COLS - 20, "██████████████", COLS, true)
    Ncurses::add_until(7, COLS - 21, "█████████████", COLS, true)
    Ncurses::add_until(8, COLS - 22, "████████", COLS, true)
    Ncurses::add_until(9, COLS - 22, "███████", COLS, true)
    Ncurses::add_until(10, COLS - 23, "█████████", COLS, true)
    Ncurses::add_until(11, COLS - 23, "███████████", COLS, true)
    Ncurses::add_until(12, COLS - 23, "███████", COLS, true)
    Ncurses::add_until(13, COLS - 23, "██████", COLS, true)
    Ncurses::add_until(14, COLS - 22, "███████", COLS, true)
    Ncurses::add_until(15, COLS - 22, "████████", COLS, true)
    Ncurses::add_until(16, COLS - 21, "██████████", COLS, true)
    Ncurses::add_until(17, COLS - 20, "█████████████", COLS, true)
    Ncurses::add_until(18, COLS - 18, "█████████████", COLS, true)
    Ncurses::add_until(19, COLS - 16, "█████████████", COLS, true)
    Ncurses::add_until(20, COLS - 13, "█████████████", COLS, true)
    Ncurses::add_until(21, COLS - 10, "██████████████", COLS, true)
    Ncurses::col(4, false)
;

fn draw_cat =>
    Ncurses::col(2)
    Ncurses::bold(true)
    let lear = rand() % 2 ? "^" : "🮧"
    let rear = rand() % 2 ? "^" : "🮧"
    Ncurses::add(LINES - 7, 5, $"  {lear}~{rear}  ,")
    Ncurses::add(LINES - 6, 5, " ('Y') )")
    Ncurses::add(LINES - 5, 5, " /   \\/ ")
    Ncurses::add(LINES - 4, 5, "(\\|||/)")
    Ncurses::bold(false)
    Ncurses::col(2, false)
;

fn draw_particles List<Particle*> particles =>
    foreach p in particles
        Ncurses::col(p->col)
        Ncurses::add(p->pos.y, p->pos.x, p->text)
        Ncurses::col(p->col, false)
        p->p_fade()
        p->p_gravity()
    ;
;