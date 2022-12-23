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
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: associations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.associations (
    id bigint NOT NULL,
    is_waldec character varying,
    id_association character varying,
    id_ex_association character varying,
    siret character varying,
    numero_reconnaissance_utilite_publique character varying,
    code_gestion character varying,
    date_creation character varying,
    date_derniere_declaration character varying,
    date_publication_creation character varying,
    date_declaration_dissolution character varying,
    nature character varying,
    groupement character varying,
    titre character varying,
    titre_court character varying,
    objet text,
    objet_social1 character varying,
    objet_social2 character varying,
    l1_adresse_import character varying,
    l2_adresse_import character varying,
    l3_adresse_import character varying,
    adresse_siege character varying,
    adresse_numero_voie character varying,
    adresse_repetition character varying,
    adresse_type_voie character varying,
    adresse_libelle_voie character varying,
    adresse_distribution character varying,
    adresse_code_insee character varying,
    adresse_code_postal character varying,
    adresse_libelle_commune character varying,
    adresse_gestion_nom character varying,
    adresse_gestion_format_postal character varying,
    adresse_gestion_geo character varying,
    adresse_gestion_libelle_voie character varying,
    adresse_gestion_distribution character varying,
    adresse_gestion_code_postal character varying,
    adresse_gestion_acheminement character varying,
    adresse_gestion_pays character varying,
    dirigeant_civilite character varying,
    telephone character varying,
    site_web character varying,
    email character varying,
    autorisation_publication_web character varying,
    observation character varying,
    position_activite character varying,
    derniere_maj character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: associations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.associations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: associations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.associations_id_seq OWNED BY public.associations.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: associations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associations ALTER COLUMN id SET DEFAULT nextval('public.associations_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: associations associations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.associations
    ADD CONSTRAINT associations_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: associations_id_association_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX associations_id_association_idx ON public.associations USING btree (id_association);


--
-- Name: associations_id_ex_association_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX associations_id_ex_association_idx ON public.associations USING btree (id_ex_association);


--
-- Name: associations_siret_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX associations_siret_idx ON public.associations USING btree (siret);


--
-- Name: index_associations_on_id_association; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_associations_on_id_association ON public.associations USING btree (id_association);


--
-- Name: index_associations_on_id_ex_association; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_associations_on_id_ex_association ON public.associations USING btree (id_ex_association);


--
-- Name: index_associations_on_siret; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_associations_on_siret ON public.associations USING btree (siret);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20180725135711');


