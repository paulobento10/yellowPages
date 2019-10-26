--
-- PostgreSQL database cluster dump
--

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE myapp_development;
DROP DATABASE myapp_test;




--
-- Drop roles
--

DROP ROLE postgres;


--
-- Roles
--

CREATE ROLE postgres;
ALTER ROLE postgres WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;






--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- Name: template1; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE template1 OWNER TO postgres;

\connect template1

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

--
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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

--
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: postgres
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

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

--
-- Name: myapp_development; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE myapp_development WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE myapp_development OWNER TO postgres;

\connect myapp_development

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

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.ar_internal_metadata OWNER TO postgres;

--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


ALTER TABLE public.schema_migrations OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying,
    "phoneNumber" character varying,
    address character varying,
    "postalCode" character varying,
    local character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: ar_internal_metadata; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2019-10-23 18:11:52.201843	2019-10-23 18:11:52.201843
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.schema_migrations (version) FROM stdin;
20191013203707
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, "phoneNumber", address, "postalCode", local, created_at, updated_at) FROM stdin;
1	Paulo Bento	911865196	Rua do Outeiro, nº170	4445-165	Alfena	2019-10-23 18:12:36.845303	2019-10-23 18:12:36.845303
2	Paulo Bento	911865196	Rua do Outeiro, nº170	4445-165	asdfgh	2019-10-23 18:29:50.530649	2019-10-23 18:29:50.530649
3	Paulo Bento	911865196	Rua do Outeiro, nº170	4445-165	asdfg	2019-10-23 18:31:52.546628	2019-10-23 18:31:52.546628
4	Paulo Bento	911865196	Rua do Outeiro, nº170	4445-165	<zxcvb	2019-10-23 18:33:54.074842	2019-10-23 18:33:54.074842
5	\N	\N	\N	\N	\N	2019-10-23 18:50:05.641313	2019-10-23 18:50:05.641313
6	\N	\N	\N	\N	\N	2019-10-23 18:51:51.444773	2019-10-23 18:51:51.444773
7	\N	\N	\N	\N	\N	2019-10-23 18:53:03.333624	2019-10-23 18:53:03.333624
8	\N	\N	\N	\N	\N	2019-10-23 18:55:10.190626	2019-10-23 18:55:10.190626
9	\N	\N	\N	\N	\N	2019-10-23 18:55:38.503313	2019-10-23 18:55:38.503313
10	\N	\N	\N	\N	\N	2019-10-23 19:04:46.92263	2019-10-23 19:04:46.92263
11	\N	\N	\N	\N	\N	2019-10-23 19:17:10.142416	2019-10-23 19:17:10.142416
12	\N	\N	\N	\N	\N	2019-10-23 19:25:35.990816	2019-10-23 19:25:35.990816
13	\N	\N	\N	\N	\N	2019-10-23 19:25:41.290501	2019-10-23 19:25:41.290501
14	\N	\N	\N	\N	\N	2019-10-23 19:50:24.020859	2019-10-23 19:50:24.020859
15	\N	\N	\N	\N	\N	2019-10-23 19:50:39.172188	2019-10-23 19:50:39.172188
16	\N	\N	\N	\N	\N	2019-10-23 19:51:05.742309	2019-10-23 19:51:05.742309
17	\N	\N	\N	\N	\N	2019-10-23 19:52:41.812934	2019-10-23 19:52:41.812934
18	\N	\N	\N	\N	\N	2019-10-23 19:53:02.181688	2019-10-23 19:53:02.181688
19	\N	\N	\N	\N	\N	2019-10-23 19:53:36.569309	2019-10-23 19:53:36.569309
20	\N	\N	\N	\N	\N	2019-10-23 19:54:10.226928	2019-10-23 19:54:10.226928
21	\N	\N	\N	\N	\N	2019-10-23 19:54:30.001009	2019-10-23 19:54:30.001009
22	\N	\N	\N	\N	\N	2019-10-23 19:55:20.358933	2019-10-23 19:55:20.358933
23	\N	\N	\N	\N	\N	2019-10-23 19:56:53.646307	2019-10-23 19:56:53.646307
24	\N	\N	\N	\N	\N	2019-10-23 20:00:13.219936	2019-10-23 20:00:13.219936
25	\N	\N	\N	\N	\N	2019-10-23 20:04:33.181116	2019-10-23 20:04:33.181116
26	\N	\N	\N	\N	\N	2019-10-26 14:45:56.480383	2019-10-26 14:45:56.480383
27	\N	\N	\N	\N	\N	2019-10-26 14:46:01.318559	2019-10-26 14:46:01.318559
28	\N	\N	\N	\N	\N	2019-10-26 14:46:01.883373	2019-10-26 14:46:01.883373
29	\N	\N	\N	\N	\N	2019-10-26 14:46:02.074504	2019-10-26 14:46:02.074504
30	\N	\N	\N	\N	\N	2019-10-26 14:46:02.247667	2019-10-26 14:46:02.247667
31	\N	\N	\N	\N	\N	2019-10-26 14:46:02.424985	2019-10-26 14:46:02.424985
32	\N	\N	\N	\N	\N	2019-10-26 14:46:02.58354	2019-10-26 14:46:02.58354
33	\N	\N	\N	\N	\N	2019-10-26 14:46:52.961751	2019-10-26 14:46:52.961751
34	\N	\N	\N	\N	\N	2019-10-26 14:47:24.895882	2019-10-26 14:47:24.895882
35	\N	\N	\N	\N	\N	2019-10-26 15:18:54.472373	2019-10-26 15:18:54.472373
36	\N	\N	\N	\N	\N	2019-10-26 15:19:37.003927	2019-10-26 15:19:37.003927
37	\N	\N	\N	\N	\N	2019-10-26 15:21:35.423092	2019-10-26 15:21:35.423092
38	\N	\N	\N	\N	\N	2019-10-26 15:23:37.898251	2019-10-26 15:23:37.898251
39	Paulo Bento	911865196	Rua do Outeiro, nº170	4445-165	Alfena	2019-10-26 15:24:35.697372	2019-10-26 15:24:35.697372
40	123	123	123	123	123	2019-10-26 15:25:25.950553	2019-10-26 15:25:25.950553
41	new	82589728	new	new	new	2019-10-26 15:26:59.321389	2019-10-26 15:26:59.321389
42	new	123456789	new	new	new	2019-10-26 15:28:32.500674	2019-10-26 15:28:32.500674
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 42, true);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

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

--
-- Name: myapp_test; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE myapp_test WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE myapp_test OWNER TO postgres;

\connect myapp_test

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

--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

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

DROP DATABASE postgres;
--
-- Name: postgres; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.utf8' LC_CTYPE = 'en_US.utf8';


ALTER DATABASE postgres OWNER TO postgres;

\connect postgres

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

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database cluster dump complete
--

