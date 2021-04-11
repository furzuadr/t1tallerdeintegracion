class SeriesController < ApplicationController
    
    def index
        encontrar_series()
    end
  
    def encontrar_series
        @episodes = find_all_episodes
        @series = []
        @seasons_serie = {}
        for e in @episodes
            serie = e['series']
            @series.append(serie) if not @series.include?(serie)
        end

        

        for serie in @series
            @seasons = []
            for e in @episodes
                temp = e['season']
                serie_e = e['series']
                if !@seasons.include?(temp) && serie_e == serie
                    @seasons.append(temp)
                end
            end
            @seasons_serie[serie] = @seasons
        end
        
    end

    def temporadas
        @temporadas = find_episodes_serie(params[:serie])
        @seasons = []
        for e in @temporadas
            temp = e['season']
            @seasons.append(temp) if not @seasons.include?(temp)
        end
    end

    def search
        offset = 0
        @personas = []
      @nuevos = find_person(params[:person], offset)
      while not @nuevos.empty?
        @personas = @personas + @nuevos
        offset = offset + 10
        @nuevos = find_person(params[:person], offset)
      end
    end

    def personajes
        @personas = find_person(params[:personaje], 0)
        @personaje = @personas.first
    end

    def episodes
        @episodios = find_episodes_serie_season(params[:serie], params[:season])
        @temporada = params[:season]
        @epi_season = []
        for e in @episodios
            epi = e['season']
            @epi_season.append(e) if epi == @temporada
        end
    end
  
    private
    def request_api(url)
      response = Excon.get(
          url
      )
      return nil if response.status != 200
      JSON.parse(response.body)
    end
  
    def find_person(name, offset)
      request_api(
          "https://tarea-1-breaking-bad.herokuapp.com/api/characters?name=#{URI.encode(name)}&limit=10&offset=#{offset}"
      )
    end

    def find_all_episodes
        request_api(
            "https://tarea-1-breaking-bad.herokuapp.com/api/episodes"
        )
      end

    def find_episodes_serie(name)
    request_api(
        "https://tarea-1-breaking-bad.herokuapp.com/api/episodes?series=#{URI.encode(name)}"
    )
    end

    def find_episodes_serie_season(serie, season)
        
        request_api(
            "https://tarea-1-breaking-bad.herokuapp.com/api/episodes?series=#{URI.encode(serie)}&season=#{URI.encode(season)}"
        )
        end


end