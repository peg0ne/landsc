# landsc

![Img](https://github.com/peg0ne/landsc/blob/main/landsc.png?raw=true)

## how to run

```
hamble++ build -r
hamble++ do make
```

## configuration for fetch

```
mkdir $HOME/.config/landsc/
touch $HOME/.config/landsc/config.json
```

This is a basic example of a config

```
{
    "width": 15,
    "inputs": [
        {
            "name": "ID",
            "static": true,
            "content": "オリバー"
        },
        {
            "name": "DAT",
            "issys": true,
            "content": "date +'%Y-%m-%d'"
        },
        {
            "name": "TIM",
            "issys": true,
            "content": "date | awk '{print $5}'"
        },
        {
            "name": "ARC",
            "issys": true,
            "content": "lscpu | grep 'Architecture:' | awk '{print $2}'"
        },
        {
            "name": "RAM",
            "issys": true,
            "suffix": "%",
            "operation": "DIV",
            "content": "free -m | grep 'Mem:' | awk '{print $3}'",
            "secondarycontent": "free -m | grep 'Mem:' | awk '{print $2}'"
        }
    ]
}
```

## `fields`

-   name -> some text to display before the fetch
-   content -> main content
-   secondarycontent -> secondary content
-   operation -> operation for content and secondary content (assumes both are numbers)
    -   ADD -> + operator
    -   SUB -> - operator
    -   DIV -> / operator
    -   MUL -> \* operator
-   issys -> boolean if fetch requires systemcall
-   static -> boolean if it's expected to not change over time
-   prefix -> prefix the content
-   suffix -> suffix the content
