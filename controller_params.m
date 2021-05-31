%% Controller R
controller_R = load('Controllers\Controller_R.mat');

R_num = controller_R.shapeit_data.C_tf.Numerator;
R_den = controller_R.shapeit_data.C_tf.Denominator;

tf_R = tf(R_num,R_den)
% tf_plant_R = H_R;

plot(error_R.Time, error_R.Data)
ss_error_R = mode(error_R.Data)
step(tf_R)
info_R = stepinfo(tf_R)
SettlingTime_R = info_R.SettlingTime

%% Controller X
controller_X = load('Controller_X.mat');

X_num = controller_X.shapeit_data.C_tf.Numerator;
X_den = controller_X.shapeit_data.C_tf.Denominator;

tf_X = tf(X_num,X_den)


% plot(error_X.Time, error_X.Data)
ss_error_X = mode(error_X.Data)
% step(tf_X)
info_X = stepinfo(tf_X);
SettlingTime_X = info_X.SettlingTime

%% Controller Z
controller_Z = load('Controller_Z.mat');

Z_num = controller_Z.shapeit_data.C_tf.Numerator;
Z_den = controller_Z.shapeit_data.C_tf.Denominator;

tf_Z = tf(Z_num,Z_den)


% plot(error_Z.Time, error_Z.Data)
ss_error_Z = mode(error_Z.Data)
% step(tf_Z)
info_Z = stepinfo(tf_Z);
SettlingTime_Z = info_Z.SettlingTime