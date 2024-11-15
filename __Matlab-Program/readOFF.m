function [vertices, faces] = readOFF(filename)
    % Open the file
    fid = fopen(filename, 'r');
    if fid == -1
        error('Cannot open file: %s', filename);
    end
    
    % Read the first line
    header = fgetl(fid);
    if ~strcmp(header, 'OFF')
        error('Not a valid OFF file: %s', filename);
    end
    
    % Read the number of vertices and faces
    dims = fscanf(fid, '%d %d %d', 3);
    numVertices = dims(1);
    numFaces = dims(2);
    
    % Read the vertex coordinates
    vertices = fscanf(fid, '%f %f %f', [3, numVertices])';
    
    % Read the face data
    faces = cell(numFaces, 1);
    for i = 1:numFaces
        faceData = fscanf(fid, '%d', 1);
        faces{i} = fscanf(fid, '%d', faceData);
    end
    
    % Close the file
    fclose(fid);
end