/*****************************************************************************

                        Copyright (c) 2010 

******************************************************************************/

implement taskWindow
    inherits applicationWindow
    open core, vpiDomains

constants
    className = "TaskWindow/taskWindow".
    classVersion = "".

clauses
    classInfo(className, classVersion).

constants
    mdiProperty : boolean = true.
clauses
    new():-
        applicationWindow::new(),
        generatedInitialize().
 
 % открыте программы (основное окно)
predicates
    onShow : window::showListener.
clauses
    onShow(_, _CreationData):-      
        MF = messageForm :: new (This),
        MF : setDecoration(titlebar([closebutton(),minimizebutton()])), 
        MF : show (),       
        MF : setVerticalSize (messageForm::parentRelative(0.3)),     
        stdio :: write ("Добро пожаловать в программу ~Кредитование в банке~ !\n"),        
        MF : setText ("~Сообщения пользователю~").
        
predicates
    onDestroy : window::destroyListener.
clauses
    onDestroy(_).

% вызов справки
predicates
    onHelpAbout : window::menuItemListener.
clauses
    onHelpAbout(TaskWin, _MenuTag):-
        _AboutDialog = aboutDialog::display(TaskWin),
         stdio :: write ("Справка - О программе\n").

predicates
    onFileExit : window::menuItemListener.
clauses
    onFileExit(_, _MenuTag):-
        close().

predicates
    onSizeChanged : window::sizeListener.
clauses
    onSizeChanged(_):-
        vpiToolbar::resize(getVPIWindow()).

% новый клиент - физ. лицо
predicates
    onEditNewClientFiz : window::menuItemListener.
clauses
    onEditNewClientFiz(S, _MenuTag) :-
      X = formNewClientFiz :: new (S), X : show (),         
      stdio :: write ("Вы выбрали добавление нового клиента - физического лица\n").

% новый клиент - юр. лицо
predicates
    onEditNewClientYur : window::menuItemListener.
clauses
    onEditNewClientYur(S, _MenuTag) :-
      X = formNewClientYur :: new (S), X : show (),         
      stdio :: write ("Вы выбрали добавление нового клиента - юридического лица\n").

% информация о клиентах - физические лица
predicates
    onFileInfoFiz : window::menuItemListener.
clauses
    onFileInfoFiz(S, _MenuTag) :-
      X = formClientFiz :: new (S), X : show (),
      stdio :: write ("Вы выбрали просмотр информации о клиентах - физических лицах\n").

% информация о клиентах - юридических лицах
predicates
    onFileInfoYur : window::menuItemListener.
clauses
    onFileInfoYur(S, _MenuTag) :-
      X = formClientYur :: new (S), X : show (),
      stdio :: write ("Вы выбрали просмотр информации о клиентах - юридических лицах\n").

% информация о заключённых договорах
predicates
    onFileDogovor : window::menuItemListener.
clauses
    onFileDogovor(S, _MenuTag) :-
      X = tabs :: new (S), X : show (),
      stdio :: write ("Вы выбрали просмотр информации о заключённых договорах\n").

% информация о необходимых документах
predicates
    onClientDoc : window::menuItemListener.
clauses
    onClientDoc(S, _MenuTag) :-
      X = formDocs :: new (S), X : show (),
      stdio :: write ("Вы выбрали просмотр информации о необходимых документах\n").

% информация о кредитовании
predicates
    onHelpLocal : window::menuItemListener.
clauses
    onHelpLocal(S, _MenuTag) :-
      X = formHelp :: new (S), X : show (),
      stdio :: write ("Вы выбрали просмотр информации о кредитовании\n").

% This code is maintained automatically, do not update it manually. 15:46:06-30.4.2010
predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setText("~Кредитование в банке~    by Sacret^^"),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_Maximized]),
        setMdiProperty(mdiProperty),
        menuSet(resMenu(resourceIdentifiers::id_TaskMenu)),
        addShowListener(generatedOnShow),
        addShowListener(onShow),
        addSizeListener(onSizeChanged),
        addDestroyListener(onDestroy),
        addMenuItemListener(resourceIdentifiers::id_help_about, onHelpAbout),
        addMenuItemListener(resourceIdentifiers::id_file_exit, onFileExit),
        addMenuItemListener(resourceIdentifiers::id_edit_new_client_fiz, onEditNewClientFiz),
        addMenuItemListener(resourceIdentifiers::id_edit_new_client_yur, onEditNewClientYur),
        addMenuItemListener(resourceIdentifiers::id_file_info_fiz, onFileInfoFiz),
        addMenuItemListener(resourceIdentifiers::id_file_info_yur, onFileInfoYur),
        addMenuItemListener(resourceIdentifiers::id_file_dogovor, onFileDogovor),
        addMenuItemListener(resourceIdentifiers::id_client_doc, onClientDoc),
        addMenuItemListener(resourceIdentifiers::id_help_local, onHelpLocal).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        projectToolbar::create(getVPIWindow()),
        statusLine::create(getVPIWindow()),
        succeed.
% end of automatic code
end implement taskWindow
