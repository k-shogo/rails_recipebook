class CreateTranscodes < ActiveRecord::Migration
  def change
    create_table :transcodes do |t|
      t.references :presentation

      t.string  :job_id
      t.string  :arn
      t.string  :pipeline_id

      t.string  :input_key
      t.string  :frame_rate
      t.string  :resolution
      t.string  :aspect_ratio
      t.string  :interlaced
      t.string  :container

      t.string  :output_key_prefix
      t.string  :output_key
      t.string  :thumbnail_pattern
      t.string  :rotate
      t.string  :preset_id

      t.integer :duration
      t.integer :width
      t.integer :height

      t.string  :status
      t.text    :status_detail

      t.timestamps
      t.timestamps
    end
  end
end
