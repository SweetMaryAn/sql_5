create table if not exists album (
	id serial primary key,
	name varchar(40) not null,
	year_release integer
);

create table if not exists track (
	id serial primary key,
	name varchar(40) not null,
	duration numeric(4,2),
	album_id integer references album(id)
);

create table if not exists collection (
	id serial primary key,
	name varchar(40) not null,
	year_release integer
);

create table if not exists track_collection (
	collection_id integer references collection(id),
	track_id integer references track(id),
	constraint pk_2 primary key (collection_id, track_id) 
);

create table if not exists musician (
	id serial primary key,
	nickname varchar(40) not null
);

create table if not exists  musician_album (
	musician_id integer references musician(id),
	album_id integer references album(id),
	constraint pk_1 primary key (musician_id, album_id)
);

create table if not exists music_genre (
	id serial primary key,
	name varchar(40) not null
);

create table if not exists musician_genre (
	musician_id integer references musician(id),
	music_genre_id integer references music_genre(id),
	constraint pk primary key (musician_id, music_genre_id)
);


