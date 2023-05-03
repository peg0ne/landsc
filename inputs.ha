struct Input_S
    string name_str
    string content
    string secondarycontent
    string operation
    string prefix
    string suffix
    bool issys
    bool isstatic
    Input_S string name_str, string content, string secondarycontent, string operation, string prefix, string suffix, bool issys, bool isstatic =>
        this->name_str = name_str
        this->content = content
        this->secondarycontent = secondarycontent
        this->operation = operation
        this->prefix = prefix
        this->suffix = suffix
        this->issys = issys
        this->isstatic = isstatic
    ;
    fn get_name => string doremi name_str
    fn output => string
        if issys
            let a_str = ""
            let a = system_output(content)
            foreach s in a do a_str += String(s).strip()
            let b_str = ""
            let b = system_output(secondarycontent)
            foreach s in b do b_str += String(s).strip()
            if operation != "" && a_str != "" && b_str != ""
                int o_val = 0
                let a_val = String(a_str).to_num().value_or(0.0)
                let b_val = String(b_str).to_num().value_or(0.0)
                if operation == "DIV"
                    o_val = ((a_val / b_val)*100)
                ;
                elif operation == "MUL"
                    o_val = ((a_val * b_val)*100)
                ;
                elif operation == "ADD"
                    o_val = ((a_val + b_val)*100)
                ;
                elif operation == "SUB"
                    o_val = ((a_val - b_val)*100)
                ;
                if isstatic
                    content = $"{prefix}{o_val}{suffix}"
                    secondarycontent = ""
                    issys = false
                    operation = ""
                    prefix = ""
                    suffix = ""
                    return content + secondarycontent
                ;
                else doremi $"{prefix}{o_val}{suffix}"
            ;
            if isstatic
                content = prefix + a_str + b_str + suffix
                secondarycontent = ""
                issys = false
                operation = ""
                prefix = ""
                suffix = ""
                return content + secondarycontent
            ;
            else doremi prefix + a_str + b_str + suffix
        ;
        return content + secondarycontent
    ;
;
class Inputs
    vector<Input_S> input_s = {}
    int width = 14
    Inputs =>
        select home from env("HOME")
            println("Loading landsc config")
            let inputs = load_json($"{home}/.config/landsc/config.json")
            println("Config loaded!")
            width = inputs.try_get_value_of("width", 0.0)
            select inps from inputs.try_get("inputs")
                for i until inps->size()
                    let name_str = ""
                    let content = ""
                    let secondarycontent = ""
                    let operation = ""
                    let prefix = ""
                    let suffix = ""
                    let issys = false
                    let isstatic = false
                    select inp from inps->try_get(i)
                        name_str = inp->try_get_value_of("name", (string)"")
                        content = inp->try_get_value_of("content", (string)"")
                        secondarycontent = inp->try_get_value_of("secondarycontent", (string)"")
                        operation = inp->try_get_value_of("operation", (string)"")
                        prefix = inp->try_get_value_of("prefix", (string)"")
                        suffix = inp->try_get_value_of("suffix", (string)"")
                        issys = inp->try_get_value_of("issys", false)
                        isstatic = inp->try_get_value_of("static", false)
                    ;
                    input_s.push_back(Input_S(name_str, content, secondarycontent, operation, prefix, suffix, issys, isstatic))
                ;
            ;
            inputs.destruct()
        ;
    ;
pub
    fn ini_colors =>
        init_pair(5, COLOR_BLACK, COLOR_WHITE)
        init_pair(8, COLOR_BLACK, 245)
        init_pair(9, COLOR_BLACK, 240)
        init_pair(10, COLOR_BLACK, 235)
        init_pair(1, COLOR_BLACK, 234)
        init_pair(6, 208, 234)
        init_pair(2, COLOR_WHITE, 234)
        init_pair(3, COLOR_WHITE, COLOR_WHITE)
        init_pair(4, 229, 234)
    ;
    fn draw_name =>
        foreach i,inp in input_s
            if i == 0 do continue
            Ncurses::add(3 + i, 5, $"{inp.get_name()}:")
        ;
    ;
    fn draw_info =>
        foreach i,inp in input_s
            if i == 0
                Ncurses::add(2, 5, inp.output())
            ;
            else
                Ncurses::add(3 + i, 10, inp.output())
            ;
        ;
    ;
    fn draw_frame =>
        let line = ""
        let space = ""
        for i until width do line += "━"; space += " "
        Ncurses::add(1, 3, $"┏━{line}━┓")
        Ncurses::add(2, 3, $"┃ {space} ┃")
        Ncurses::add(3, 3, $"┃ {line} ┃")
        let end = -1
        if input_s.size() > 0
            for i until input_s.size() - 1
                Ncurses::add(4 + i, 3, $"┃ {space} ┃")
                end = i
            ;
        ;
        Ncurses::add(4 + end + 1, 3, $"┗━{line}━┛")
    ;
;