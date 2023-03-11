struct Particle
    string text = ""
    Vector pos = Vector(0,0)
    int z = 0
    bool gravity = false
    short col = 0
    Particle string text, Vector pos, bool gravity, short col, int z =>
        this->text = text
        this->pos = pos
        this->gravity = gravity
        this->col = col
        this->z = z
    ;
    fn p_gravity =>
        pos.y += gravity ? 1 : 0
        if pos.y == LINES - 3 do col = 3
    ;
    fn p_fade =>
        if rand() % 30 == 0 do pos.y = LINES
    ;

;

fn Snow => Particle* doremi new Particle(
        "✽",
        Vector(rand() % (COLS - 1), -1),
        true,
        2,
        rand() % 3
    )

fn Star => Particle* doremi new Particle(
        rand() % 2 == 0 ? "*" : ".",
        Vector(rand() % (COLS - 1), rand() % (LINES - 6)),
        false,
        4,
        0
    )

fn clear_particles List<Particle*> *particles =>
    for i until particles->size()
        let p = particles->at(i)
        if p->pos.y >= LINES - (1 + p->z)
            particles->remove(i)
            delete(p)
            clear_particles(particles)
            break
        ;
    ;
;