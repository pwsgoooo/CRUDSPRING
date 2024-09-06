create table board
(
    id         integer   default nextval('board_id_seq1'::regclass) not null
        primary key,
    title      varchar(255)                                         not null,
    content    text                                                 not null,
    reg_date   timestamp default CURRENT_TIMESTAMP,
    reg_ip     varchar(45),
    reg_member varchar(255),
    mod_date   timestamp default CURRENT_TIMESTAMP,
    mod_ip     varchar(45),
    mod_member varchar(255),
    del_date   timestamp,
    del_ip     varchar(45)
);

alter table board
    owner to postgres;

create table board_comment
(
    id         bigserial
        primary key,
    parent_id  bigint,
    board_id   bigint,
    comment    text,
    reg_date   timestamp,
    reg_ip     varchar(45),
    reg_member varchar(255),
    mod_date   timestamp,
    mod_ip     varchar(45),
    mod_member varchar(255),
    del_date   timestamp,
    del_ip     varchar(45),
    del_member varchar(255)
);

alter table board_comment
    owner to postgres;

create table board_file
(
    file_uuid  uuid default uuid_generate_v4() not null
        primary key,
    board_id   bigint                          not null,
    name       varchar(250)                    not null,
    size       bigint                          not null,
    mime_type  varchar(100)                    not null,
    reg_date   timestamp                       not null,
    reg_ip     varchar(15)                     not null,
    reg_member varchar(20)                     not null
);

alter table board_file
    owner to postgres;

create table member
(
    user_id    varchar(20)  not null
        primary key,
    user_pw    varchar(100) not null,
    name       varchar(20)  not null,
    phone      varchar(12),
    email      varchar(100),
    state      varchar(1)   not null,
    reg_date   timestamp    not null,
    reg_ip     varchar(15)  not null,
    reg_member varchar(20),
    mod_date   timestamp,
    mod_ip     varchar(15),
    mod_member varchar(20),
    office     varchar(20),
    depart     varchar(20)
);

alter table member
    owner to postgres;




