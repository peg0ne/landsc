inc => unistd.h
get => ncurses, list, files, stringextensions
get => json, print, dictionary
get => particle, drawers, inputs

fn main =>
    srand(time(NULL))
    let inputs = Inputs()
    let particles = List<Particle*>()
    Ncurses::init()
    inputs.ini_colors()
    Ncurses::start(true)
    loop
        Ncurses::clearScr()
        draw_background()
        draw_particles(particles)
        let t = time(0)
        let now = localtime(&t)
        draw_moon()
        draw_ground()
        Ncurses::col(6)
        inputs.draw_frame()
        inputs.draw_name()
        Ncurses::col(4)
        inputs.draw_info()
        draw_cat()
        if Ncurses::key() == 'q' do break
        particles.add(Snow())
        if rand() % 6 == 0 do particles.add(Star())
        clear_particles(&particles)
        usleep(100000)
    ;
    Ncurses::stop()
;