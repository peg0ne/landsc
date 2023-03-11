fn draw_background Ncurses *n =>
    n->col(4)
    for i until LINES
        for j until COLS
            n->add(i, j, " ")
        ;
    ;
    n->col(4, false)
;

fn draw_ground Ncurses *n =>
    for i until COLS
        n->col(10)
        n->add(LINES - 3, i, "🭶")
        n->col(9)
        n->add(LINES - 2, i, "🮀")
        n->col(8)
        n->add(LINES - 1, i, "🮁")
    ;
    n->col(5, false)
;

fn draw_moon Ncurses *n =>
    n->col(4)
    n->add_until(2, COLS - 10, "███████████████", COLS, true)
    n->add_until(3, COLS - 13, "██████████████", COLS, true)
    n->add_until(4, COLS - 16, "██████████████", COLS, true)
    n->add_until(5, COLS - 18, "██████████████", COLS, true)
    n->add_until(6, COLS - 20, "██████████████", COLS, true)
    n->add_until(7, COLS - 21, "█████████████", COLS, true)
    n->add_until(8, COLS - 22, "████████", COLS, true)
    n->add_until(9, COLS - 22, "███████", COLS, true)
    n->add_until(10, COLS - 23, "█████████", COLS, true)
    n->add_until(11, COLS - 23, "███████████", COLS, true)
    n->add_until(12, COLS - 23, "███████", COLS, true)
    n->add_until(13, COLS - 23, "██████", COLS, true)
    n->add_until(14, COLS - 22, "███████", COLS, true)
    n->add_until(15, COLS - 22, "████████", COLS, true)
    n->add_until(16, COLS - 21, "██████████", COLS, true)
    n->add_until(17, COLS - 20, "█████████████", COLS, true)
    n->add_until(18, COLS - 18, "█████████████", COLS, true)
    n->add_until(19, COLS - 16, "█████████████", COLS, true)
    n->add_until(20, COLS - 13, "█████████████", COLS, true)
    n->add_until(21, COLS - 10, "██████████████", COLS, true)
    n->col(4, false)
;

fn draw_cat Ncurses *n =>
    n->col(2)
    n->bold(true)
    let lear = rand() % 2 ? "^" : "🮧"
    let rear = rand() % 2 ? "^" : "🮧"
    n->add(LINES - 7, 5, $"  {lear}~{rear}  ,")
    n->add(LINES - 6, 5, " ('Y') )")
    n->add(LINES - 5, 5, " /   \\/ ")
    n->add(LINES - 4, 5, "(\\|||/)")
    n->bold(false)
    n->col(2, false)
;

fn draw_particles Ncurses *n, List<Particle*> particles =>
    foreach p in particles
        n->col(p->col)
        n->add(p->pos.y, p->pos.x, p->text)
        n->col(p->col, false)
        p->p_fade()
        p->p_gravity()
    ;
;