app.factory('Mountain', ['$http', '$q', function($http, $q) {

    var urlBase = '/mountains';

    return {
      
      get: function() {
          var deferred = $q.defer();
          $http.get(urlBase).then(function(response){
             deferred.resolve(response.data);
          })
          .catch(function(response){
            deferred.reject(response);
          });
          return deferred.promise;
      },

      get_forecast: function( mountain ) {
        var deferred = $q.defer();
        $http({
          url: urlBase + '/'+ 'forecast', 
          method: "GET",
          params: {mountain: mountain.zip_code}
        }).then(function(response) {
          deferred.resolve(response['data'])
        })
        .catch(function(response) {

          deferred.reject(response)

        });
        return deferred.promise;
      },

      get_traffic_alerts: function(road) {
        var deferred = $q.defer();
        $http({
          url: urlBase + '/' + 'alert',
          method: 'GET',
          params: road
        }).then(function(response) {
          
          deferred.resolve(response['data'])

        })
        .catch(function(response) {
          deferred.reject(response)
        });
        return deferred.promise;

       
      },

      get_traffic_images: function(road) {
        var deferred = $q.defer();
        $http({
          url: urlBase + '/' + 'images',
          method: 'GET',
          params: road
        }).then(function(response) {
          
          deferred.resolve(response['data'])

        })
        .catch(function(response) {
          deferred.reject(response)
        });
        return deferred.promise;

       
      }


      
    }
  
  }]);