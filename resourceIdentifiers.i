/************************************************************************
      This file is handled by the Visual Development Environment       
************************************************************************/

interface resourceIdentifiers
constants
    id_taskmenu = 10000.
    id_file = 10001.
    id_file_info = 10002.
    id_file_info_fiz = 10003.
    id_file_info_yur = 10004.
    id_file_dogovor = 10005.
    id_file_exit = 10006.
    id_client = 10007.
    id_edit_new_client = 10008.
    id_edit_new_client_fiz = 10009.
    id_edit_new_client_yur = 10010.
    id_client_doc = 10011.
    id_help = 10012.
    id_help_local = 10013.
    id_help_about = 10014.
    idi_errorpresentation_info = 10015.
    idi_errorpresentation_warning = 10016.
    idi_errorpresentation_error = 10017.
    idb_info2 = 10018.
    idb_help2 = 10019.
    idb_dialog = 10020.
    idb_new = 10021.
    idb_zakl_dog = 10022.
    idb_info = 10023.
    idt_help_line = 10024.

    acceleratorList : vpiDomains::accel_List =
        [
        vpiDomains::a(vpiDomains::k_f1, vpiDomains::c_Nothing, id_help_local),
        vpiDomains::a(vpiDomains::k_f3, vpiDomains::c_Nothing, id_edit_new_client),
        vpiDomains::a(vpiDomains::k_esc, vpiDomains::c_Nothing, id_file_exit),
        vpiDomains::a(vpiDomains::k_f8, vpiDomains::c_Nothing, id_file_dogovor)
        ].
end interface resourceIdentifiers
