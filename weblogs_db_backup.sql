--
-- PostgreSQL database dump
--

-- Dumped from database version 14.17 (Debian 14.17-1.pgdg120+1)
-- Dumped by pg_dump version 14.17 (Debian 14.17-1.pgdg120+1)

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
-- Name: logs; Type: TABLE; Schema: public; Owner: ps_user
--

CREATE TABLE public.logs (
    id integer NOT NULL,
    ip_address text,
    method text,
    path text,
    user_agent text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.logs OWNER TO ps_user;

--
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: ps_user
--

CREATE SEQUENCE public.logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.logs_id_seq OWNER TO ps_user;

--
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ps_user
--

ALTER SEQUENCE public.logs_id_seq OWNED BY public.logs.id;


--
-- Name: logs id; Type: DEFAULT; Schema: public; Owner: ps_user
--

ALTER TABLE ONLY public.logs ALTER COLUMN id SET DEFAULT nextval('public.logs_id_seq'::regclass);


--
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: ps_user
--

COPY public.logs (id, ip_address, method, path, user_agent, created_at) FROM stdin;
1	10.244.0.1:24399	GET	/	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-04 23:39:08.210281
2	10.244.0.1:24399	GET	/favicon.ico	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-04 23:39:09.308786
3	10.244.0.1:52088	GET	/	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-04 23:41:09.9663
4	10.244.0.1:52088	GET	/favicon.ico	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-04 23:41:11.059551
5	10.244.0.1:62687	GET	/	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-04 23:45:00.779364
6	10.244.0.1:62687	GET	/favicon.ico	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-04 23:45:01.872272
7	10.244.0.1:50046	GET	/	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-04 23:50:30.83597
8	10.244.0.1:50046	GET	/favicon.ico	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-04 23:50:31.915865
9	10.244.0.1:65394	GET	/	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-05 00:51:19.267437
10	10.244.0.1:65394	GET	/favicon.ico	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-05 00:51:20.891473
11	10.244.0.1:49329	GET	/	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-05 01:03:15.796483
12	10.244.0.1:49329	GET	/favicon.ico	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-05 01:03:17.063131
13	10.244.0.1:22122	GET	/	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-05 03:33:09.52487
14	10.244.0.1:22122	GET	/favicon.ico	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-05 03:33:12.870511
15	10.244.0.1:19025	GET	/	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-05 05:15:56.66801
16	10.244.0.1:19025	GET	/favicon.ico	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-05 05:15:57.844247
17	10.244.0.1:47053	GET	/	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-05 05:19:52.172439
18	10.244.0.1:47053	GET	/favicon.ico	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-05 05:19:53.255131
19	10.244.0.1:45628	GET	/	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-05 06:22:31.416285
20	10.244.0.1:45628	GET	/favicon.ico	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-05 06:22:33.70002
21	10.244.0.1:54990	GET	/	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-05 06:24:20.565794
22	10.244.0.1:54990	GET	/favicon.ico	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-05 06:24:22.826429
23	10.244.0.1:54990	GET	/	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-05 06:24:25.797888
24	10.244.0.1:54990	GET	/favicon.ico	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-05 06:24:26.869547
25	10.244.0.1:54990	GET	/	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-05 06:24:28.133935
26	10.244.0.1:54990	GET	/favicon.ico	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36 OPR/118.0.0.0	2025-05-05 06:24:29.232824
\.


--
-- Name: logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ps_user
--

SELECT pg_catalog.setval('public.logs_id_seq', 26, true);


--
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: ps_user
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

