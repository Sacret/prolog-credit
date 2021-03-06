/*****************************************************************************

                        Copyright (c) 2010 

******************************************************************************/

implement formDocs
    inherits formWindow
    open core, vpiDomains

constants
    className = "formDocs/formDocs".
    classVersion = "".

clauses
    classInfo(className, classVersion).

clauses
    display(Parent) = Form :-
        Form = new(Parent),
        Form:show().

clauses
    new(Parent):-
        formWindow::new(Parent),
        generatedInitialize().

predicates
    onShow : window::showListener.
clauses
    onShow(_Source, _Data) :-
      listbox_ctl : addList (["анкета-заявление", "копия паспорта", "ф. 2 - НДФЛ","справка по ф. банка", "полис ДМС"]),
      listBox1_ctl : addList (["анкета-заявление", "копия паспорта", "копия декларации о доходах за предыдущий год", "документы, подтверждающие текущее финансовое состояние", "справка из ГНИ об отсутствии задолженности по налогам"]).
      

% This code is maintained automatically, do not update it manually. 13:52:41-27.4.2010
facts
    listbox_ctl : listBox.
    listBox1_ctl : listBox.

predicates
    generatedInitialize : ().
clauses
    generatedInitialize():-
        setFont(vpi::fontCreateByName("Tahoma", 8)),
        setText("~Необходимые документы~"),
        setRect(rct(50,40,290,146)),
        setDecoration(titlebar([closebutton(),maximizebutton(),minimizebutton()])),
        setBorder(sizeBorder()),
        setState([wsf_ClipSiblings,wsf_ClipChildren]),
        menuSet(noMenu),
        addShowListener(generatedOnShow),
        addShowListener(onShow),
        listbox_ctl := listBox::new(This),
        listbox_ctl:setPosition(12, 26),
        listbox_ctl:setSize(216, 20),
        listBox1_ctl := listBox::new(This),
        listBox1_ctl:setPosition(12, 74),
        listBox1_ctl:setSize(216, 20),
        StaticText_ctl = textControl::new(This),
        StaticText_ctl:setText("Для физических лиц"),
        StaticText_ctl:setPosition(84, 6),
        StaticText_ctl:setSize(72, 14),
        ДляФизическихЛиц_ctl = textControl::new(This),
        ДляФизическихЛиц_ctl:setText("Для юридических лиц"),
        ДляФизическихЛиц_ctl:setPosition(84, 54),
        ДляФизическихЛиц_ctl:setSize(72, 14).

predicates
    generatedOnShow: window::showListener.
clauses
    generatedOnShow(_,_):-
        succeed.
% end of automatic code
end implement formDocs
