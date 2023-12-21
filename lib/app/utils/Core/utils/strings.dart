
//!!!!! app Strings

const String baseurl = 'https://api.sportmonks.com/v3/football/';
const String apiToken =
    'api_token=ZrrkK1QZXgKPXmIO6mDHJ6CKg84jzuzp1VpaeKJmDxy4rah4dDXWXunvcBZ3';
const String apiHeaders =
    'Content-Type=application/json&Accept=application/json&';

const String standingEndPoint = 'standings?';

//
const String allsportsapi = 'https://apiv2.allsportsapi.com/football/?met=';
const String allsportsapiKey =
    '&APIkey=8394e131ee748b2f6751d35e38b3e2e32e55381d076943fe31491dab7186b750&';
const String saudiaCountryID = '&countryId=97';
const String saudiaLeague = '&leagueId=278';
const String englishLeague = '&leagueId=152';

// End Points
const String fixturesEndPoint = 'Fixtures';
const String topScorerapi = 'Topscorers&leagueId=278';
const String standingsEndPoint = 'Standings&leagueId=278';
const String liveMatchEndPoint = 'Livescore';
//All Sport APi Filtter
const String fixturesFromTo = 'from=2023-09-14&to=2023-09-16';

//! Roshan Teams

final Map<String, Map<String, dynamic>> leaguesTeams = {
  'Al Hilal': {'https://apiv2.allsportsapi.com/logo/366_al-hilal.jpg': 0},
  'Al Nassr': {'https://apiv2.allsportsapi.com/logo/371_al-nassr.jpg': 1},
  'Al Ahli': {'https://apiv2.allsportsapi.com/logo/359_al-ahli.jpg': 2},
  'Al Taawon': {'https://apiv2.allsportsapi.com/logo/368_al-taawon.jpg': 3},
  'Al Ittihad': {
    'https://apiv2.allsportsapi.com/logo/6328_al-ittihad.jpg': 4
  },
  'Damak': {'https://apiv2.allsportsapi.com/logo/6336_damak.jpg': 5},
  'Al Fateh': {'https://apiv2.allsportsapi.com/logo/6331_al-fateh.jpg': 6},
  'Al Ittifaq': {
    'https://apiv2.allsportsapi.com/logo/6329_al-ittifaq.jpg': 7
  },
  'Al Wehda': {'https://apiv2.allsportsapi.com/logo/362_al-wehda.jpg': 8},
  'Al Fayha': {'https://apiv2.allsportsapi.com/logo/6308_al-fayha.jpg': 9},
  'Al Shabab': {'https://apiv2.allsportsapi.com/logo/6327_al-shabab.jpg': 10},
  'Al Tai': {'https://apiv2.allsportsapi.com/logo/6310_al-tai.jpg': 11},
  'Al Khaleej': {
    'https://apiv2.allsportsapi.com/logo/6312_al-khaleej.jpg': 12
  },
  'Al Riyadh': {
    'https://apiv2.allsportsapi.com/logo/16129_al-riyadh.jpg': 13
  },
  'Al Raed': {'https://apiv2.allsportsapi.com/logo/6334_al-raed.jpg': 14},
  'Al Akhdoud': {
    'https://apiv2.allsportsapi.com/logo/18903_al-akhdoud.jpg': 15
  },
  'Abha': {'https://apiv2.allsportsapi.com/logo/6332_abha.jpg': 16},
  'Al Hazm': {'https://apiv2.allsportsapi.com/logo/6307_al-hazm.jpg': 17},
};
