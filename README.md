# README

### Тестовое задание

Для получения топ 5 игроков по конкретному показателю по всем командам
```
Players::TopPlayersQueryObject.call(indicator: indicator_instance)
```

Получение топ 5 игроков по конкретному показателю и конкретой команде
```
Players::TopPlayersQueryObject.call(indicator: indicator_instance, team: team_instance)
```
___

Проверка, выполнил ли игрок конкретный показатель хотя бы 1 раз за предыдущие 5 матчей команды
```
Players::ExistsPlayerWithIndicatorInLastMatchesService.call(player: player_instance, indicator: indicator_instance)
```

___

Отметить, что игрок выполнил определенный показатель в матче
```
MatchPlayerIndicatorCreator.call(player: player_instance, indicator: indicator_instance, match: match_instance)
```

Так как необязательно, что игрок выполнит показатель за матч, indicator является необязательным
```
MatchPlayerIndicatorCreator.call(player: player_instance, match: match_instance)
```

##### Что можно было реализовать

В задание не очень было понятно по поводу индикаторов.

По идее, можно было реализовать индикаторы с дополнительными полями.
Например, одно числовое поле, в котором бы указывался, например, процент точных передач
В другом же поле мы бы записывали сам индикатор, либо текст, либо enum значение, и указать сам текст уже в локалях

Это дало бы нам больше гибкости, а также более расширенный поиск.
Например, если мы ищем игроков, которые выполнили 70% точных передач, то также бы учитывали и игроков, у которые 90% точности передач

