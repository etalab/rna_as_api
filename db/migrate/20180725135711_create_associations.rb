class CreateAssociations < ActiveRecord::Migration[5.2]
  def change
    create_table :associations do |t|
      t.string :is_waldec
      t.string :id_association, index: true
      t.string :id_ex_association
      t.string :siret
      t.string :numero_reconnaissance_utilite_publique
      t.string :code_gestion
      t.string :date_creation
      t.string :date_derniere_declaration
      t.string :date_publication_creation
      t.string :date_declaration_dissolution
      t.string :nature
      t.string :groupement
      t.string :titre
      t.string :titre_court
      t.string :objet
      t.string :objet_social1
      t.string :objet_social2
      t.string :adresse_siege
      t.string :adresse_numero_voie
      t.string :adresse_repetition
      t.string :adresse_type_voie
      t.string :adresse_libelle_voie
      t.string :adresse_distribution
      t.string :adresse_code_insee
      t.string :adresse_code_postal
      t.string :adresse_libelle_commune
      t.string :adresse_gestion_nom
      t.string :adresse_gestion_format_postal
      t.string :adresse_gestion_geo
      t.string :adresse_gestion_libelle_voie
      t.string :adresse_gestion_distribution
      t.string :adresse_gestion_code_postal
      t.string :adresse_gestion_acheminement
      t.string :adresse_gestion_pays
      t.string :dirigeant_civilite
      t.string :telephone
      t.string :site_web
      t.string :email
      t.string :autorisation_publication_web
      t.string :observation
      t.string :position_activite
      t.string :derniere_maj
      t.timestamps
    end

    execute 'create index on associations (id_association);'
  end
end
