#
# Copyright 2012, Deutsche Telekom Laboratories 
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#VBoxManage list vms
#"ubuntu__8063" {2bbef874-c459-4ece-afcb-a85ac6d674a4}
#"ubuntu__4475" {84a1d4b5-9848-4c28-8cf2-99110315ce99}
#"ubuntu__3289" {2a9c7e3b-fa4c-47bc-867d-4bdaad02e67f}

vm_names = lambda { |vm| vm.match(/"(.*)".*\{(.*)\}/)[1]} 
running_vms = %x{VBoxManage list runningvms}.map(&vm_names)
all_vms = %x{VBoxManage list vms}.map(&vm_names)


running_vms.each do |vm|
  puts "stopping #{vm}" 
  %x[VBoxManage controlvm #{vm} poweroff]  
  puts "stopped #{vm}"	
end

sleep 10

all_vms.each do |vm|
  puts "deleting #{vm}" 
  %x[VBoxManage unregistervm #{vm} --delete]
  puts "deleted #{vm}"   
end



