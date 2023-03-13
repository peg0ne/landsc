inc => unistd.h
get => ncurses, list, files, stringextensions
get => json, print, dictionary
get => particle, drawers, inputs

fn main =>
    srand(time(NULL))
    let inputs = Inputs()
    let particles = List<Particle*>()
    let n = Ncurses()
    inputs.ini_colors()
    n.start(true)
    loop
        n.clearScr()
        draw_background(&n)
        draw_particles(&n, particles)
        let t = time(0)
        let now = localtime(&t)
        draw_moon(&n)
        draw_ground(&n)
        n.col(6)
        inputs.draw_frame(&n)
        inputs.draw_name(&n)
        n.col(4)
        inputs.draw_info(&n)
        draw_cat(&n)
        if n.key() == 'q' do break
        particles.add(Snow())
        if rand() % 6 == 0 do particles.add(Star())
        clear_particles(&particles)
        usleep(100000)
    ;
    n.stop()
;