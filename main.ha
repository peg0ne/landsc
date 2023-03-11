inc => unistd.h
get => ncurses, list, files, stringextensions
get => particle, drawers

fn main =>
    let usr = system_output("whoami")
    let usrname = ""
    foreach s in usr do usrname += String(s).strip()
    let arc = system_output("lscpu | grep 'Architecture:' | awk '{print $2}'")
    let archi = ""
    foreach s in arc do archi += String(s).strip()
    srand(time(NULL))
    List<Particle*> particles = List<Particle*>()
    let n = Ncurses()
    init_pair(5, COLOR_BLACK, COLOR_WHITE)
    init_pair(8, COLOR_BLACK, 245)
    init_pair(9, COLOR_BLACK, 240)
    init_pair(10, COLOR_BLACK, 235)
    init_pair(1, COLOR_BLACK, 234)
    init_pair(6, 208, 234)
    init_pair(2, COLOR_WHITE, 234)
    init_pair(3, COLOR_WHITE, COLOR_WHITE)
    init_pair(4, 229, 234)
    n.start(true)
    loop
        n.clearScr()
        draw_background(&n)
        draw_particles(&n, particles)
        let t = time(0)
        let now = localtime(&t)
        draw_moon(&n)
        draw_ground(&n)
        let arc = system_output("lscpu | grep 'Architecture:' | awk '{print $2}'")
        let archi = ""
        foreach s in arc do archi += String(s).strip()
        let tim = system_output("date | awk '{print $5}'")
        let timed = ""
        foreach s in tim do timed += String(s).strip()
        let max = system_output("free -m | grep 'Mem:' | awk '{print $2}'")
        let maxmem = ""
        foreach s in max do maxmem += String(s).strip()
        let used = system_output("free -m | grep 'Mem:' | awk '{print $3}'")
        let usedmem = ""
        foreach s in used do usedmem += String(s).strip()
        let usedperc =  String(usedmem).to_num().value_or(0.0) / String(maxmem).to_num().value_or(0.0)
        usedperc *= 100
        n.col(6)
        n.add(1, 3, $"┏━━━━━━━━━━━━━━━━┓")
        n.add(2, 3, $"┃                ┃")
        n.add(3, 3, $"┃ ━━━━━━━━━━━━━━ ┃")
        n.add(4, 3, $"┃ DAT:           ┃")
        n.add(5, 3, $"┃ TIM:           ┃")
        n.add(6, 3, $"┃ ARC:           ┃")
        n.add(7, 3, $"┃ RAM:           ┃")
        n.add(8, 3, $"┗━━━━━━━━━━━━━━━━┛")
        n.col(4)
        n.add(2, 5, $"オリバー")
        n.add(4, 9, $" {now->tm_mday}/{now->tm_mon + 1}-{now->tm_year + 1900}")
        n.add(5, 9, $" {timed}")
        n.add(6, 9, $" {archi}")
        n.add(7, 9, $" {(int)usedperc}%")
        n.col(4, false)
        draw_cat(&n)
        if n.key() == 'q' do break
        particles.add(Snow())
        if rand() % 6 == 0 do particles.add(Star())
        clear_particles(&particles)
        usleep(100000)
    ;
    n.stop()
;