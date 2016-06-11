var app = angular.module('resultApp',[]);

app.controller('MainCtrl', function($scope, $http) {

  resultRubyUrl = "ruby.json"
  resultJavaRubyUrl = "jruby.json"

  $scope.checked= false;
  $http.get(resultRubyUrl).success(function(data) {
     $http.get(resultJavaRubyUrl).success(function(data2) {
    $scope.charts = data.features;
    data.features.jruby = data2.features.jruby
    console.log($scope.charts);

    for (key in $scope.charts.jruby){
      // console.log($scope.charts.features[key])
      $(function () {
          // alert('#chart'+key)
          $('#chart'+key).highcharts({

              type: 'line',
              title: {
                  text: 'Matrix '+key,
                  x: -20 //center
              },
              subtitle: {
                  x: -20
              },
              xAxis: {
                title: {
                  text: 'Number of elements in one Matrix'
                },
              },
              yAxis: {
                  title: {
                      text: 'Time (s)'
                  },
                  plotLines: [{
                      value: 0,
                      width: 1,
                      color: '#808080'
                  }]
              },
              tooltip: {
                  valueSuffix: 's'
              },
              legend: {
                  layout: 'vertical',
                  align: 'right',
                  verticalAlign: 'middle',
                  borderWidth: 0
              },
              series: [{
                  name: "ruby",
                  data: $scope.charts.ruby[key]
                },{
                  name: "jruby",
                  data: $scope.charts.jruby[key]
                },
              ]
        });
        });
    }
  });
  });

  // $http.get(resultJavaRubyUrl).success(function(data) {
  //   $scope.charts = data;
  //   console.log(data);
  // });
})
  // $(function () {
//   $http.get(resultRubyUrl).success(function(data) {
//   $http.get(resultJavaRubyUrl).success(function(data2) {
//     $('#container').highcharts({

//         type: 'line',
//         title: {
//             text: 'Matrix addition',
//             x: -20 //center
//         },
//         subtitle: {
//             x: -20
//         },
//         xAxis: {
//             tickInterval: 1,
//             categories: [10,1000,100000,100000000]
//         },
//         yAxis: {
//             title: {
//                 text: 'Time (ms)'
//             },
//             plotLines: [{
//                 value: 0,
//                 width: 1,
//                 color: '#808080'
//             }]
//         },
//         tooltip: {
//             valueSuffix: '°C'
//         },
//         legend: {
//             layout: 'vertical',
//             align: 'right',
//             verticalAlign: 'middle',
//             borderWidth: 0
//         },
//         series: [{
//             name: "addition",
//             data: data.ruby.addition
//           },
//           {
//             name : "jrubyadd",
//             data : data2.jruby.addition
//           }
//         ]
//     });
//     });
//   });
//   });


// });

resultRubyUrl = "ruby.json"
resultJavaRubyUrl = "jruby.json"

