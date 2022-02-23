-- 1. количество исполнителей в каждом жанре
select m.name, count(mg.musician_id) from music_genre m
	left join musician_genre mg on m.id = mg.music_genre_id
	group by m.name;
	
-- 2. количество треков, вошедших в альбомы 2019-2020 годов
select count(t.name) from track t 
	join album a on t.album_id = a.id 
	where a.year_release >= 2019;

-- 3. средняя продолжительность треков по каждому альбому
select a.name, avg(t.duration) from track t 
	join album a on t.album_id = a.id 
	group by a.name;
	
-- 4. все исполнители, которые не выпустили альбомы в 2020 году	
select nickname from musician
	where nickname not in (select m.nickname from musician m
			join musician_album ma on m.id = ma.musician_id
			join album a on ma.album_id = a.id
			where year_release = 2020
			group by m.nickname)
	
-- 5. названия сборников, в которых присутствует конкретный исполнитель
select a.name from musician m 
	join musician_album ma on m.id = ma.musician_id 
	join album a on ma.album_id = a.id
	where nickname = 'Matthew Bellamy'

-- 6. название альбомов, в которых присутствуют исполнители более 1 жанра
select distinct a.name from album a 
	join musician_album ma on a.id = ma.album_id 
	join musician m on ma.musician_id = m.id 
	join musician_genre mg on m.id = mg.musician_id
	join music_genre mg2 on mg.music_genre_id = mg2.id
	group by m.nickname, a.name 
	having count(distinct mg2.name) > 1
	
-- 7. наименование треков, которые не входят в сборники
select t.name from track t 
	left join track_collection tc on t.id = tc.track_id
	where tc.collection_id IS NULL
	
-- 8. исполнителя(-ей), написавшего самый короткий по продолжительности трек (теоретически таких треков может быть несколько)
select m.nickname from musician m 
	join musician_album ma on m.id = ma.musician_id
	join album a on ma.album_id = a.id
	join track t on a.id = t.album_id
	where duration = (
		select min(duration) from track)	
	
-- 9. название альбомов, содержащих наименьшее количество треков.
select name from (
	select a.name, count(t.name) c from album a 
		join track t on a.id = t.album_id
		group by a.name) r2
	where r2.c = (select min(r1.c) from
		(select a.name, count(t.name) c from album a 
			join track t on a.id = t.album_id
			group by a.name) r1)


	
	
	
	
	