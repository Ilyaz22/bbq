class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_event, only: %i[show edit update destroy]
  #before_action :set_current_user_event, only: [:edit, :update, :destroy]
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: %i[index]

  # GET /events
  def index
    @events = policy_scope(Event)
    authorize @events
  end

  # GET /events/1
  def show
    authorize @event
    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
    @new_photo = @event.photos.build(params[:photo])
  end

  # GET /events/new
  def new
    @event = current_user.events.build
    authorize @event
  end

  # GET /events/1/edit
  def edit
    authorize @event
  end

  # POST /events
  def create
    @event = current_user.events.build(event_params)
    authorize @event

    if @event.save
      redirect_to @event, notice: t('controllers.events.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /events/1
  def update
    authorize @event

    if @event.update(event_params)
      redirect_to @event, notice: t('controllers.events.updated')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /events/1
  def destroy
    @event.destroy
    redirect_to events_url, notice: t('controllers.events.destroyed')
  end

  private

    # def set_current_user_event
    #   @event = current_user.events.find(params[:id])
    # end

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :address, :datetime, :description)
    end
end
