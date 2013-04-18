@JoinCtrl = ['$scope', '$http', '$location', ($scope, $http, $location) ->
  $scope.init = (data) ->
    [$scope.labels, $scope.joined] = data
    $scope.updateLabel()
    $scope.disabled = !$scope.user?
    if $scope.disabled
      $scope.href = "/users/sign_in?return_to=#{$location.absUrl()}"
  $scope.updateLabel = ->
    $scope.label = " #{$scope.labels[$scope.joined]}"
    $scope.status = if $scope.joined then 'btn-warning' else 'btn-success'
  $scope.join = ->
    return if $scope.disabled
    $scope.joined = !$scope.joined
    $scope.updateLabel()
    action = if $scope.joined then 'join' else 'unjoin'
    $http.post("/events/#{$scope.event.id}/#{action}").success (data) -> $scope.count = data.count
]
