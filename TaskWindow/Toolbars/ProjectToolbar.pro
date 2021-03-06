/*****************************************************************************

                        Copyright (c) 2010 

******************************************************************************/

implement projectToolbar
    open core, vpiDomains, vpiToolbar, resourceIdentifiers

constants
    className = "TaskWindow/Toolbars/projectToolbar".
    classVersion = "".

clauses
    classInfo(className, classVersion).

clauses
    create(Parent):-
        _ = vpiToolbar::create(style, Parent, controlList).

% This code is maintained automatically, do not update it manually. 12:34:22-27.4.2010
constants
    style : vpiToolbar::style = tb_top().
    controlList : vpiToolbar::control_list =
        [
        tb_ctrl(id_file_info_fiz,pushb(),resId(idb_info),"Информация о клиентах - физические лица;Информация о клиентах - физические лица",1,1),
        tb_ctrl(id_file_info_yur,pushb(),resId(idb_info2),"Информация о клиентах - юридические лица;Информация о клиентах - юридические лица",1,1),
        tb_ctrl(id_file_dogovor,pushb(),resId(idb_zakl_dog),"Заключённые договоры;Заключённые договоры",1,1),
        vpiToolbar::separator,
        tb_ctrl(id_edit_new_client_fiz,pushb(),resId(idb_new),"Новый клиент - физическое лицо;Новый клиент - физическое лицо",1,1),
        tb_ctrl(id_edit_new_client_yur,pushb(),resId(idb_dialog),"Новый клиент - юридическое лицо;Новый клиент - юридическое лицо",1,1),
        vpiToolbar::separator,
        tb_ctrl(id_help_local,pushb(),resId(idb_help2),"Информация о кредитовании;Информация о кредитовании",1,1)
        ].
% end of automatic code
end implement projectToolbar
