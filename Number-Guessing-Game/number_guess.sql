--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE number_guess;
--
-- Name: number_guess; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE number_guess WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE number_guess OWNER TO freecodecamp;

\connect number_guess

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: games; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.games (
    game_id integer NOT NULL,
    user_id integer,
    total_guesses integer DEFAULT 0 NOT NULL,
    result_value integer
);


ALTER TABLE public.games OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.games_game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.games_game_id_seq OWNER TO freecodecamp;

--
-- Name: games_game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.games_game_id_seq OWNED BY public.games.game_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(22)
);


ALTER TABLE public.users OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO freecodecamp;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: games game_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games ALTER COLUMN game_id SET DEFAULT nextval('public.games_game_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.games VALUES (1, 3, 12, 714);
INSERT INTO public.games VALUES (2, 7, 211, 210);
INSERT INTO public.games VALUES (3, 7, 984, 983);
INSERT INTO public.games VALUES (4, 8, 232, 231);
INSERT INTO public.games VALUES (5, 8, 845, 844);
INSERT INTO public.games VALUES (6, 7, 400, 397);
INSERT INTO public.games VALUES (7, 7, 694, 693);
INSERT INTO public.games VALUES (8, 7, 619, 618);
INSERT INTO public.games VALUES (9, 10, 635, 634);
INSERT INTO public.games VALUES (10, 10, 804, 803);
INSERT INTO public.games VALUES (11, 11, 705, 704);
INSERT INTO public.games VALUES (12, 11, 738, 737);
INSERT INTO public.games VALUES (13, 10, 222, 219);
INSERT INTO public.games VALUES (14, 10, 543, 542);
INSERT INTO public.games VALUES (15, 10, 219, 218);
INSERT INTO public.games VALUES (16, 3, 10, 833);
INSERT INTO public.games VALUES (17, 12, 181, 180);
INSERT INTO public.games VALUES (18, 12, 848, 847);
INSERT INTO public.games VALUES (19, 13, 17, 16);
INSERT INTO public.games VALUES (20, 13, 716, 715);
INSERT INTO public.games VALUES (21, 12, 107, 104);
INSERT INTO public.games VALUES (22, 12, 287, 286);
INSERT INTO public.games VALUES (23, 12, 337, 336);
INSERT INTO public.games VALUES (24, 14, 797, 796);
INSERT INTO public.games VALUES (25, 14, 67, 66);
INSERT INTO public.games VALUES (26, 15, 814, 813);
INSERT INTO public.games VALUES (27, 15, 824, 823);
INSERT INTO public.games VALUES (28, 14, 43, 40);
INSERT INTO public.games VALUES (29, 14, 590, 589);
INSERT INTO public.games VALUES (30, 14, 650, 649);
INSERT INTO public.games VALUES (31, 3, 28, 407);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.users VALUES (3, 'aric');
INSERT INTO public.users VALUES (4, 'user_1737231777660');
INSERT INTO public.users VALUES (5, 'user_1737231777659');
INSERT INTO public.users VALUES (6, 'ARIC');
INSERT INTO public.users VALUES (7, 'user_1737233298048');
INSERT INTO public.users VALUES (8, 'user_1737233298047');
INSERT INTO public.users VALUES (9, 'user_173723298048');
INSERT INTO public.users VALUES (10, 'user_1737233580595');
INSERT INTO public.users VALUES (11, 'user_1737233580594');
INSERT INTO public.users VALUES (12, 'user_1737233697018');
INSERT INTO public.users VALUES (13, 'user_1737233697017');
INSERT INTO public.users VALUES (14, 'user_1737233783021');
INSERT INTO public.users VALUES (15, 'user_1737233783020');


--
-- Name: games_game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.games_game_id_seq', 31, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.users_user_id_seq', 15, true);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (game_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: games games_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- PostgreSQL database dump complete
--

