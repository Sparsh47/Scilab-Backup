clc
clear

prices = [
    1, 2, 3;
    8, 5, 4;
    3, 1, 6
];

demand = [100, 30, 70];
supply = [110, 40, 50];

prices = evstr(x_matrix('setprices', prices));
demand = evstr(x_matrix('setdemand', demand));
supply = evstr(x_matrix('submit offer', supply));

LEFT = 1;
RIGHT = 2;
UP = 3;
DOWN = 4;

% Function for calculating the cost of the transportation plan
function res = cost(prices, plan)
    cntCols = length(prices(1, :));
    cntRows = length(prices(:, 1));
    res = 0;

    for i = 1:cntRows
        for j = 1:cntCols
            res = res + prices(i, j) * plan(i, j);
        end
    end
end

% Function to find available corners in a given direction
% and return them in descending order of proximity to the edge
function [corners, success] = getAvailableCorner(basis, direction, initialPoint, i, j)
    success = 0;
    corners = [];
    currentCorner = 1;

    cntCols = length(basis(1, :));
    cntRows = length(basis(:, 1));

    colModificator = 0;
    rowModificator = 0;

    if direction == LEFT
        colModificator = -1;
    end
    if direction == RIGHT
        colModificator = 1;
    end
    if direction == UP
        rowModificator = -1;
    end
    if direction == DOWN
        rowModificator = 1;
    end

    i = i + rowModificator;
    j = j + colModificator;

    while i ~= 0 && j ~= 0 && i <= cntRows && j <= cntCols
        if basis(i, j) ~= 0 || [i, j] == initialPoint
            corners(currentCorner, :) = [i, j];
            currentCorner = currentCorner + 1;
            success = 1;
        end

        i = i + rowModificator;
        j = j + colModificator;
    end

    if success == 1
        cornersReverse = [];
        for iter = 1:length(corners(:, 1))
            cornersReverse(iter, :) = corners(length(corners(:, 1)) - iter + 1, :);
        end

        corners = cornersReverse;
    end
end

% Recursive looping function
function [nodes, success] = buildCycle(basis, initialPoint, currentPoint, direction)
    success = 0;
    nodes = [];

    possibleDirections = [];
    if initialPoint == currentPoint
        possibleDirections = [LEFT, RIGHT, UP, DOWN];
    elseif direction == LEFT || direction == RIGHT
        possibleDirections = [UP, DOWN];
    elseif direction == UP || direction == DOWN
        possibleDirections = [LEFT, RIGHT];
    end

    for directionIdx = 1:length(possibleDirections)
        [corners, suc] = getAvailableCorner(basis, possibleDirections(directionIdx), initialPoint, currentPoint(1), currentPoint(2));
        if suc == 1
            possibleToCloseCycle = 0;
            successWithCorners = 0;

            for cornIdx = 1:length(corners(:, 1))
                if corners(cornIdx, :) == initialPoint
                    possibleToCloseCycle = 1;
                    continue;
                end

                [subNodes, suc] = buildCycle(basis, initialPoint, corners(cornIdx, :), possibleDirections(directionIdx));
                if suc == 1
                    successWithCorners = 1;
                    nodeIdx = 1;
                    nodes(nodeIdx, :) = currentPoint;

                    for subNodeIdx = 1:length(subNodes(:, 1))
                        nodeIdx = nodeIdx + 1;
                        nodes(nodeIdx, :) = subNodes(subNodeIdx, :);
                    end

                    break;
                end
            end

            if successWithCorners == 1
                success = 1;
                break;
            elseif possibleToCloseCycle == 1
                nodes(1, :) = currentPoint;
                nodes(2, :) = initialPoint;
                success = 1;
                break;
            end
        end
    end
end

cntCols = length(prices(1, :));
cntRows = length(prices(:, 1));

plan = []; % Reference plan
plan(cntRows, cntCols) = 0; % Fill with zeros

% Calculation of the initial reference plan using the Northwest Corner Method
tempDemand = demand;
tempSupply = supply;

for j = 1:cntCols % Iterate over columns (customers)
    for i = 1:cntRows % Iterate over rows (suppliers)
        currentSupply = min(tempDemand(j), tempSupply(i));
        plan(i, j) = currentSupply;
        tempDemand(j) = tempDemand(j) - currentSupply;
        tempSupply(i) = tempSupply(i) - currentSupply;

        if tempDemand(j) == 0
            break;
        end
    end
end

disp("Initial plan:");
disp(plan);
fprintf("\nThe cost is %d units.\n\n\n", cost(prices, plan));

% Plan optimization
optimal = 0;
UNKNOWN_POTENCIAL = 9999999;
iteration = 0;

while optimal ~= 1
    iteration = iteration + 1;
    potencialU = [];
    potencialV = [];

    for i = 1:cntRows
        potencialU(i) = UNKNOWN_POTENCIAL; % Type unknown potential
    end

    for i = 1:cntCols
        potencialV(i) = UNKNOWN_POTENCIAL;
    end

    potencialU(1) = 0;
    continuePotentialing = 1;

    % Calculation of potentials by points in the route
    while continuePotentialing == 1
        continuePotentialing = 0;

        % Continue calculating potentials if
        % for one of the plan values, both potentials are unknown
        for j = 1:cntCols % Iterate over columns (customers)
            for i = 1:cntRows % Iterate over rows (suppliers)
                if plan(i, j) == 0
                    continue;
                end

                if potencialU(i) == UNKNOWN_POTENCIAL && potencialV(j) == UNKNOWN_POTENCIAL
                    continuePotentialing = 1;
                    continue;
                end

                if potencialU(i) == UNKNOWN_POTENCIAL
                    potencialU(i) = prices(i, j) - potencialV(j);
                end

                if potencialV(j) == UNKNOWN_POTENCIAL
                    potencialV(j) = prices(i, j) - potencialU(i);
                end
            end
        end
    end

    % Calculating estimates for non-basic variables
    notBasis = []; % Reference plan
    notBasis(1, :) = -1; % Fill with -1
    notBasis(1, cntCols + cntRows) = 0;

    for j = 1:cntCols % Iterate over columns (customers)
        for i = 1:cntRows % Iterate over rows (suppliers)
            if plan(i, j) ~= 0
                continue;
            end

            notBasis(1, j) = prices(i, j) - potencialU(i) - potencialV(j);

            if notBasis(1, cntCols + cntRows) > notBasis(1, j)
                notBasis(1, cntCols + cntRows) = notBasis(1, j);
                notBasis(1, cntCols + cntRows + 1) = i;
                notBasis(1, cntCols + cntRows + 2) = j;
            end
        end
    end

    % If there are no negative estimates, then the plan is optimal
    if notBasis(1, cntCols + cntRows) >= 0
        optimal = 1;
    else
        % Building a cycle and calculating delta
        currentCycle = []; % Reference plan
        currentCycle(1, :) = -1; % Fill with -1

        currentCycle(1, 1) = notBasis(1, cntCols + cntRows + 1);
        currentCycle(1, 2) = notBasis(1, cntCols + cntRows + 2);

        currentPoint = [currentCycle(1, 1), currentCycle(1, 2)];
        direction = 0;

        success = 0;
        iterationLimit = cntCols * cntRows;

        while success == 0 && iterationLimit > 0
            iterationLimit = iterationLimit - 1;

            [cycle, success] = buildCycle(plan, currentPoint, currentPoint, direction);

            if success == 0
                fprintf("Cannot build cycle! (iterationLimit: %d)\n", iterationLimit);
                break;
            end

            % Find theta
            theta = plan(cycle(1, 1), cycle(1, 2));

            for cycleIdx = 2:length(cycle(:, 1))
                if mod(cycleIdx, 2) == 1
                    if plan(cycle(cycleIdx, 1), cycle(cycleIdx, 2)) < theta
                        theta = plan(cycle(cycleIdx, 1), cycle(cycleIdx, 2));
                    end
                else
                    if plan(cycle(cycleIdx, 1), cycle(cycleIdx, 2)) > theta
                        theta = plan(cycle(cycleIdx, 1), cycle(cycleIdx, 2));
                    end
                end
            end

            % Update the plan
            for cycleIdx = 1:length(cycle(:, 1))
                if mod(cycleIdx, 2) == 1
                    plan(cycle(cycleIdx, 1), cycle(cycleIdx, 2)) = plan(cycle(cycleIdx, 1), cycle(cycleIdx, 2)) + theta;
                else
                    plan(cycle(cycleIdx, 1), cycle(cycleIdx, 2)) = plan(cycle(cycleIdx, 1), cycle(cycleIdx, 2)) - theta;

                    if plan(cycle(cycleIdx, 1), cycle(cycleIdx, 2)) == 0
                        break;
                    end
                end
            end

            % Update current point and direction
            currentPoint = [cycle(1, 1), cycle(1, 2)];

            if mod(length(cycle(:, 1)), 2) == 1
                direction = RIGHT;
            else
                direction = DOWN;
            end
        end

        disp("Plan after iteration:");
        disp(iteration);
        disp(plan);
        fprintf("\nThe cost is %d units.\n\n\n", cost(prices, plan));
    end
end

disp("Optimal plan:");
disp(plan);
fprintf("\nThe cost is %d units.\n\n\n", cost(prices, plan));
