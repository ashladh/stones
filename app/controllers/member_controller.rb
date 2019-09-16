class MemberController < ApplicationController
  before_action :authenticate_user!
  layout "member"
end