--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.2

-- Started on 2020-04-23 13:13:28 IST

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
-- TOC entry 2992 (class 1262 OID 16385)
-- Name: ias-db; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE "ias-db" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_IN' LC_CTYPE = 'en_IN';


ALTER DATABASE "ias-db" OWNER TO postgres;

\connect -reuse-previous=on "dbname='ias-db'"

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
-- TOC entry 2993 (class 0 OID 0)
-- Name: ias-db; Type: DATABASE PROPERTIES; Schema: -; Owner: postgres
--

ALTER DATABASE "ias-db" CONNECTION LIMIT = 100;


\connect -reuse-previous=on "dbname='ias-db'"

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
-- TOC entry 6 (class 2615 OID 16386)
-- Name: ias-schema; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "ias-schema";


ALTER SCHEMA "ias-schema" OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 206 (class 1259 OID 16477)
-- Name: PendingRequests; Type: TABLE; Schema: ias-schema; Owner: postgres
--

CREATE TABLE "ias-schema"."PendingRequests" (
    "serviceId" character varying NOT NULL,
    "serverIp" character varying,
    "sshPort" character varying,
    username character varying,
    "serviceName" character varying,
    "applicationName" character varying,
    "sshUsername" character varying,
    "sshPassword" character varying
);


ALTER TABLE "ias-schema"."PendingRequests" OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16423)
-- Name: topology; Type: TABLE; Schema: ias-schema; Owner: postgres
--

CREATE TABLE "ias-schema".topology (
    username character varying,
    "serviceId" character varying NOT NULL,
    status character varying,
    port character varying,
    ip character varying,
    "containerId" character varying,
    "redeployRequest" character varying,
    "serviceName" character varying,
    "applicationName" character varying,
    "dependencyCount" bigint
);


ALTER TABLE "ias-schema".topology OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16447)
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16497)
-- Name: guest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.guest (
    guest_id bigint NOT NULL,
    first_name character varying(64),
    last_name character varying(64),
    email_address character varying(64),
    address character varying(64),
    country character varying(32),
    state character varying(12),
    phone_number character varying(24)
);


ALTER TABLE public.guest OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16495)
-- Name: guest_guest_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.guest_guest_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.guest_guest_id_seq OWNER TO postgres;

--
-- TOC entry 2994 (class 0 OID 0)
-- Dependencies: 209
-- Name: guest_guest_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.guest_guest_id_seq OWNED BY public.guest.guest_id;


--
-- TOC entry 205 (class 1259 OID 16452)
-- Name: pendingrequests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pendingrequests (
    "serviceId" character varying NOT NULL,
    "serverIp" character varying,
    "sshPort" character varying,
    "userId" character varying,
    "serviceName" character varying
);


ALTER TABLE public.pendingrequests OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16505)
-- Name: reservation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservation (
    reservation_id bigint NOT NULL,
    room_id bigint NOT NULL,
    guest_id bigint NOT NULL,
    res_date date
);


ALTER TABLE public.reservation OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16503)
-- Name: reservation_reservation_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservation_reservation_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reservation_reservation_id_seq OWNER TO postgres;

--
-- TOC entry 2995 (class 0 OID 0)
-- Dependencies: 211
-- Name: reservation_reservation_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservation_reservation_id_seq OWNED BY public.reservation.reservation_id;


--
-- TOC entry 208 (class 1259 OID 16487)
-- Name: room; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.room (
    room_id bigint NOT NULL,
    name character varying(16) NOT NULL,
    room_number character(2) NOT NULL,
    bed_info character(2) NOT NULL
);


ALTER TABLE public.room OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16485)
-- Name: room_room_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.room_room_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.room_room_id_seq OWNER TO postgres;

--
-- TOC entry 2996 (class 0 OID 0)
-- Dependencies: 207
-- Name: room_room_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.room_room_id_seq OWNED BY public.room.room_id;


--
-- TOC entry 2830 (class 2604 OID 16500)
-- Name: guest guest_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guest ALTER COLUMN guest_id SET DEFAULT nextval('public.guest_guest_id_seq'::regclass);


--
-- TOC entry 2831 (class 2604 OID 16508)
-- Name: reservation reservation_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation ALTER COLUMN reservation_id SET DEFAULT nextval('public.reservation_reservation_id_seq'::regclass);


--
-- TOC entry 2829 (class 2604 OID 16490)
-- Name: room room_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room ALTER COLUMN room_id SET DEFAULT nextval('public.room_room_id_seq'::regclass);


--
-- TOC entry 2980 (class 0 OID 16477)
-- Dependencies: 206
-- Data for Name: PendingRequests; Type: TABLE DATA; Schema: ias-schema; Owner: postgres
--

COPY "ias-schema"."PendingRequests" ("serviceId", "serverIp", "sshPort", username, "serviceName", "applicationName", "sshUsername", "sshPassword") FROM stdin;
\.


--
-- TOC entry 2977 (class 0 OID 16423)
-- Dependencies: 203
-- Data for Name: topology; Type: TABLE DATA; Schema: ias-schema; Owner: postgres
--

COPY "ias-schema".topology (username, "serviceId", status, port, ip, "containerId", "redeployRequest", "serviceName", "applicationName", "dependencyCount") FROM stdin;
admin	admin_actionmanager	alive	5052	127.0.0.1	\N	false	actionmanager	platform	0
admin	admin_deployer	alive	8888	127.0.0.1	\N	false	deployer	platform	0
admin	admin_monitoring	alive	5055	127.0.0.1	\N	false	monitoring	platform	0
admin	admin_requestmanager	alive	5057	127.0.0.1	\N	false	requestmanager	platform	0
admin	admin_scheduler	alive	5053	127.0.0.1	\N	false	scheduler	platform	0
admin	admin_sensormanager	alive	5050	127.0.0.1	\N	false	sensormanager	platform	0
admin	admin_sensorregistration	alive	5051	127.0.0.1	\N	false	sensorregistration	platform	0
admin	admin_serverlcm	alive	5054	127.0.0.1	\N	false	serverlcm	platform	0
admin	admin_sensorupload	alive	5056	127.0.0.1	\N	false	sensorupload	platform	0
\.


--
-- TOC entry 2978 (class 0 OID 16447)
-- Dependencies: 204
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
f1f99375f77f
\.


--
-- TOC entry 2984 (class 0 OID 16497)
-- Dependencies: 210
-- Data for Name: guest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.guest (guest_id, first_name, last_name, email_address, address, country, state, phone_number) FROM stdin;
\.


--
-- TOC entry 2979 (class 0 OID 16452)
-- Dependencies: 205
-- Data for Name: pendingrequests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pendingrequests ("serviceId", "serverIp", "sshPort", "userId", "serviceName") FROM stdin;
\.


--
-- TOC entry 2986 (class 0 OID 16505)
-- Dependencies: 212
-- Data for Name: reservation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reservation (reservation_id, room_id, guest_id, res_date) FROM stdin;
\.


--
-- TOC entry 2982 (class 0 OID 16487)
-- Dependencies: 208
-- Data for Name: room; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.room (room_id, name, room_number, bed_info) FROM stdin;
\.


--
-- TOC entry 2997 (class 0 OID 0)
-- Dependencies: 209
-- Name: guest_guest_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.guest_guest_id_seq', 1, false);


--
-- TOC entry 2998 (class 0 OID 0)
-- Dependencies: 211
-- Name: reservation_reservation_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservation_reservation_id_seq', 1, false);


--
-- TOC entry 2999 (class 0 OID 0)
-- Dependencies: 207
-- Name: room_room_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.room_room_id_seq', 1, false);


--
-- TOC entry 2839 (class 2606 OID 16484)
-- Name: PendingRequests pendingrequests_pkey; Type: CONSTRAINT; Schema: ias-schema; Owner: postgres
--

ALTER TABLE ONLY "ias-schema"."PendingRequests"
    ADD CONSTRAINT pendingrequests_pkey PRIMARY KEY ("serviceId");


--
-- TOC entry 2833 (class 2606 OID 16430)
-- Name: topology topology_pkey; Type: CONSTRAINT; Schema: ias-schema; Owner: postgres
--

ALTER TABLE ONLY "ias-schema".topology
    ADD CONSTRAINT topology_pkey PRIMARY KEY ("serviceId");


--
-- TOC entry 2835 (class 2606 OID 16451)
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- TOC entry 2845 (class 2606 OID 16502)
-- Name: guest guest_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.guest
    ADD CONSTRAINT guest_pkey PRIMARY KEY (guest_id);


--
-- TOC entry 2837 (class 2606 OID 16459)
-- Name: pendingrequests pendingrequests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pendingrequests
    ADD CONSTRAINT pendingrequests_pkey PRIMARY KEY ("serviceId");


--
-- TOC entry 2848 (class 2606 OID 16510)
-- Name: reservation reservation_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_pkey PRIMARY KEY (reservation_id);


--
-- TOC entry 2841 (class 2606 OID 16492)
-- Name: room room_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_pkey PRIMARY KEY (room_id);


--
-- TOC entry 2843 (class 2606 OID 16494)
-- Name: room room_room_number_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.room
    ADD CONSTRAINT room_room_number_key UNIQUE (room_number);


--
-- TOC entry 2846 (class 1259 OID 16521)
-- Name: idx_res_date_; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_date_ ON public.reservation USING btree (res_date);


--
-- TOC entry 2850 (class 2606 OID 16516)
-- Name: reservation reservation_guest_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_guest_id_fkey FOREIGN KEY (guest_id) REFERENCES public.guest(guest_id);


--
-- TOC entry 2849 (class 2606 OID 16511)
-- Name: reservation reservation_room_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation
    ADD CONSTRAINT reservation_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.room(room_id);


-- Completed on 2020-04-23 13:13:28 IST

--
-- PostgreSQL database dump complete
--

