/**********************************************************************

   Audacity - A Digital Audio Editor
   Copyright 1999-2009 Audacity Team
   File License: wxWidgets

   Dan Horgan

******************************************************************//**

\file AppCommandEvent.h
\brief Headers and event table macros for AppCommandEvent

*//*******************************************************************/

#ifndef __APPCOMMANDEVENT__
#define __APPCOMMANDEVENT__

#include <wx/event.h>
#include "../Audacity.h"
#include "../MemoryX.h"

DECLARE_EXPORTED_EVENT_TYPE(AUDACITY_DLL_API, wxEVT_APP_COMMAND_RECEIVED, -1);

class Command;
using CommandHolder = std::shared_ptr<Command>;

class AppCommandEvent final : public wxCommandEvent
{
private:
   CommandHolder mCommand;

public:
   AppCommandEvent(wxEventType commandType = wxEVT_APP_COMMAND_RECEIVED, int id = 0);

   AppCommandEvent(const AppCommandEvent &event);
   ~AppCommandEvent();

   wxEvent *Clone() const override;
   void SetCommand(const CommandHolder &cmd);
   CommandHolder GetCommand();

private:
   DECLARE_DYNAMIC_CLASS(AppCommandEvent)
};

typedef void (wxEvtHandler::*wxAppCommandEventFunction)(AppCommandEvent&);

#define wxAppCommandEventHandler(func) \
    (wxObjectEventFunction)(wxEventFunction)wxStaticCastEvent(wxAppCommandEventFunction, &func)

#define EVT_APP_COMMAND(winid, fn) DECLARE_EVENT_TABLE_ENTRY( wxEVT_APP_COMMAND_RECEIVED, winid, wxID_ANY, wxAppCommandEventHandler(fn), (wxObject *) NULL ),

#endif /* End of include guard: __APPCOMMANDEVENT__ */
