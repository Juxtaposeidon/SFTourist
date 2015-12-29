class ShownearbyController < ApplicationController
  def index
  end

  def load
    @resulttrack = 0
    @@resultspage = 0
    @showprev = false
    @shownext = true
    @@allspots = Place.near([params['lat'], params['long']], 10, :order => "distance").limit(100)
    @nearbyspots = Place.near([params['lat'], params['long']], 10, :order => "distance").limit(100)[@@resultspage..@@resultspage+9]
    render :json => {
      :partial => render_to_string(:partial => 'shownearby/map')
    }
  end

  def locate
    locationdata = Place.find(params["location"])
    locationlat = locationdata.latitude
    locationlong = locationdata.longitude
    render :json => {
      :lat => locationlat,
      :long => locationlong
    }
  end

  def nextresults
    @@resultspage += 10
    @resulttrack = @@resultspage
    @showprev = @@resultspage > 0
    @shownext = @@resultspage < 90
    @nearbyspots = @@allspots[@@resultspage..@@resultspage+9]
    p @nearbyspots
    render :json => {
      :partial => render_to_string(:partial => 'shownearby/locations')
    }
  end

  def prevresults
  end


end
