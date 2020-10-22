#
# Copyright (C) 2020 - present Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.

class CreateSubscriptionsForPlagiarismTools < ActiveRecord::Migration[5.2]
  tag :postdeploy

  def up
    DataFixup::CreateSubscriptionsForPlagiarismTools.send_later_if_production_enqueue_args(
      :create_subscriptions,
      strand: "plagiarism_subscription_create_#{Shard.current.id}"
    )
  end

  def down
    DataFixup::CreateSubscriptionsForPlagiarismTools.send_later_if_production_enqueue_args(
      :delete_subscriptions,
      strand: 'plagiarism_subscription_delete'
    )
  end
end
