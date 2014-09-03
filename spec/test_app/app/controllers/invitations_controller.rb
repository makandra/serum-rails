# Sends, accept and dismisses conference invitations.
# origin: M
class InvitationsController < ApplicationController

  resource_controller

  permissions :invitations

  in_sections :conferences, :invitations

  def create
    invitation = current_user.sent_invitations.create!(object_params)
    flash[:notice] = "You have invited #{current_user.name_for(invitation.recipient)} to #{invitation.conference.name}"
    redirect_to new_invitation_path(:invitation => { :conference_id => invitation.conference.id})
  end

  def accept
    object.accept!
    flash[:success] = "You have signed up for #{object.conference.name}"
    redirect_to object.conference
  end

  def dismiss
    object.dismiss!
    flash[:notice] = "Invitation dismissed"
    redirect_to conferences_path
  end

  def end_of_association_chain
    current_user.received_invitations
  end

  private

  def object_params
    (super || {}).slice(:conference_id, :recipient_id)
  end

end
