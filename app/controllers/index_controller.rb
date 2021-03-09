require 'open-uri'
class IndexController < ApplicationController

    def choose_license; end

    def get_versions
        current_license = License.find_by(id: params[:license][:id])
        last_version_date = JSON.load(URI.open(API_ADDRESS)).to_a[0][1].to_date
        @version_arr = Array.new(5){ |i| last_version_date-i.month }
        @version_arr.select!{|el| el <= current_license.paid_till}
        if current_license.max_version
            max_version = (current_license.max_version.to_s.insert(0, '20') + '.01').to_date 
            @version_arr.select!{|el| el <= max_version.to_date}
        end
        if current_license.min_version
            min_version = (current_license.min_version.to_s.insert(0, '20') + '.01').to_date
            @version_arr.select!{|el| el >= min_version}
        end
        if !@version_arr.empty?
            @version_arr.map!{|el| el.strftime("%y.%m")}
        else
            @version_arr = current_license.paid_till.strftime("%y.%m")
            if max_version && max_version <= current_license.paid_till
                @version_arr = max_version.strftime("%y.%m")
            end
        end
    end

    def new_license
        new_date = (params["paid_till(1i)"]+'.'+ params["paid_till(2i)"] + '.' + params["paid_till(3i)"]).to_date
        License.create(paid_till: new_date, min_version: params[:min_version], max_version: params[:max_version],)
    end

    private

    API_ADDRESS = "http://localhost:4000/flussoniclastversion/get?format=json".freeze
end
