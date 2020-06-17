# local TASKS=~/Personal/Mindmap/Boards/Tasks.md
# local LIST=~/Personal/Notes/inbox/list-of-contexts.md
#local HIGHLIGHTS_URL= moz-extension://ccd698fc-13e3-4eea-8adb-7df50092d616/content/addon-page/addon-page.html#page=history
#local QNOTES=~/Personal/Mindmap/qnotes.md
#local SS=~/Media/Pictures/Screenshots

press_enter() {
    echo  "Press enter to continue"
    read
}

tasks() {
    echo "Internalize these:"
    task limit:5
    press_enter
}

inbox() {
    local EMAIL_URL='https://mail.google.com/mail/u/0/#inbox'
    local NEPTUN_URL='https://hallgato.neptun.elte.hu/main.aspx'

    if [ "$1" = "daily" ]; then
        echo "Process Quicknotes"
        press_enter
        vim ~/Personal/Mindmap/quick-capture.md
        echo "Process Moleskine"
        press_enter
        echo "Process Email"
        xdg-open $EMAIL_URL
        press_enter
        echo "Process Neptun"
        xdg-open $NEPTUN_URL
        press_enter
    elif [ "$1" = "weekly" ]; then
        echo "Process your inboxes"
        press_enter
        echo "Notes"
        press_enter
        echo "Tray"
        press_enter
        echo "Bookmarks"
        press_enter
    fi
}

habits() {
    local HABITS=~/Personal/Mindmap/Boards/Habits.md

    echo "Check your habits"
    press_enter
    taskell $HABITS 2> /dev/null
}

calendar() {
    local CALENDAR_URL='https://calendar.google.com' 

    echo "Check your calendar"
    xdg-open $CALENDAR_URL
    press_enter
}

goals() {
    local GOALS=~/Personal/Mindmap/Boards/Goals.md

    echo "Update you goals"
    press_enter
    taskell $GOALS 2> /dev/null
}

journal() {
    echo "List 5 things you are grateful for"
    press_enter
    nvim ~/Personal/Mindmap/gratitude/$(echo $(date) | awk '{print $4"-"$3"-"$2".md"}')
}

list() {
    echo "Check the list to remind yourself"
    cat $LIST
    echo
    press_enter
}

time_spent() {
    local DASHBOARD_URL='https://www.rescuetime.com/dashboard?src=client'
    local WEEKLY_DASHBOARD_URL=https://www.rescuetime.com/dashboard/for/the/week/of/$(date +"%Y-%m-%d")

    if [ "$1" = "daily" ]; then
        echo "Reflect on time spent"
        xdg-open $DASHBOARD_URL
        press_enter
    elif [ "$1" = "weekly" ]; then
        echo "Reflect on time spent"
        xdg-open $WEEKLY_DASHBOARD_URL
        press_enter
    fi
}

projects() {
    echo "Check the statuses of your projects"
    press_enter
}


#time_spent
##echo "Process your notesheet"
##press_enter
##echo "Enter missed courses"
##press_enter
#inbox
#calendar
##goals
#echo "Review habits"
#press_enter
#habits
#projects
#list
#echo "Write list for tomorrow"
#press_enter
#tasks
#journal
#echo "Reset everything"
#press_enter
#echo "Pack for tomorrow"
#press_enter



# tasks() {
#     # TODO do this with taskwarrior reports
# }

qnotes() {
    echo "Review your qnotes"
    press_enter
    vim $QNOTES
}

projects() {
    local PROJECTS=~/Personal/Mindmap/Boards/Projects.md

    echo "Review your projects"
    press_enter
    taskell $PROJECTS 2> /dev/null
}

push_notes(){
    echo "Organize your notes!"
    press_enter
}

reading() {
    echo "Review what you read this week"
    echo "Review what your web highlights"
    xdg-open $HIGHLIGHTS_URL
    echo "Review your kindle highlights"
    press_enter
}

expenses() {
    echo "Reflect on expenses"
    press_enter
}

exercises() {
    echo "Reflect on exercises done"
    press_enter
}

anki() {
    echo "Review marked cards."
    press_enter
    echo "Review stats."
    press_enter
}

files() {
    echo "Organize your files."
    press_enter
}

screenshots() {
    echo "Review you screenshots."
    press_enter
    ranger $SS
}



# time_spent
# inbox
# projects
# goals
# reading
# screenshots
# qnotes
# files
# organiz_notes
# list
# tasks
# expenses
# exercises
# anki
